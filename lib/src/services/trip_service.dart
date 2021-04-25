import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:glinkwok_provider/src/repository/data_repository.dart';
import 'package:glinkwok_provider/src/util/location_helper.dart';
import 'package:simplest/simplest.dart';

enum AccountStatus { document, card, onboarding, approved, banned, balance }
enum ServiceStatus { offline, active, balance }
enum CheckStatus {
  empty,
  searching,
  accepted,
  started,
  arrived,
  pickedup,
  dropped,
  completed,
  patch,
  cancelled,
  scheduled,
}

enum PaymentType { CASH, DEBIT_MACHINE, VOUCHER, CARD }

extension EnumTypes on String {
  AccountStatus toAccountStatus() =>
      AccountStatus.values.firstWhere((str) => describeEnum(str) == this);
  ServiceStatus toServiceStatus() =>
      ServiceStatus.values.firstWhere((str) => describeEnum(str) == this);
  CheckStatus toCheckStatus() => CheckStatus.values.firstWhere(
      (str) => describeEnum(str).toLowerCase() == this.toLowerCase());
  PaymentType toPaymentType() =>
      PaymentType.values.firstWhere((item) => describeEnum(item) == this);
}

@lazySingleton
class TripService {
  TripResponse get tripResponse => _tripSubject.value;
  AccountStatus get accountStatus =>
      _tripSubject.value?.accountStatus?.toAccountStatus();
  ServiceStatus get serviceStatus =>
      _tripSubject.value?.serviceStatus?.toServiceStatus();
  CheckStatus get checkStatus => _getCheckStatusFromTrip(tripResponse);
  Stream<CheckStatus> get statusStream =>
      _tripSubject.stream.map((event) => _getCheckStatusFromTrip(event));

  final _dataRepo = locator<DataRepository>();
  final _location = locator<LocationService>();

  bool _getTripLocked = false;
  BehaviorSubject<TripResponse> _tripSubject = BehaviorSubject<TripResponse>();
  double endLat = 0;
  double endLng = 0;
  double bearing = 0;
  String key = "";
  StreamSubscription _tripSubscription;

  void registerTripService(int providerId) {
    logger.d('registerTripService with providerId: $providerId');
    DatabaseReference _tripRef = FirebaseDatabase.instance
        .reference()
        .child('/trip/provider/$providerId/trip_details');
    _tripSubscription = _tripRef.onValue.listen((event) {
      final data = event.snapshot.value;
      print(data);
      getTrip();
    });
    getTrip();
  }

  getTrip() async {
    if (_getTripLocked) {
      return;
    }
    try {
      _getTripLocked = true;
      TripResponse _tripResponse = await _dataRepo.getTrip(
          latitude: _location.position.latitude,
          longitude: _location.position.longitude);
      _tripSubject.add(_tripResponse);
      if (_tripResponse.requests.length > 0) {
        saveLocationToFireBaseDB(_tripResponse.requests.first.requestId,
            _location.position.latitude, _location.position.longitude);
      }
      log('----- ACCOUNT STATUS: $accountStatus ');
      log('----- SERVICE STATUS: $serviceStatus ');
      log('----- CHECK STATUS: $checkStatus ');
      _getTripLocked = false;
    } catch (e) {
      _handleTripError(e);
    }
  }

  void _handleTripError(dynamic error) async {
    logger.e(error);
    if (error is DioError && error.response.statusCode == 401) {
      locator<SnackbarService>()
          .showSnackbar(message: 'please_relogin_to_continue'.tr);
      _getTripLocked = true;
      await Future.delayed(Duration(seconds: 3));
      locator<NavigationService>()
          .pushNamedAndRemoveUntil(AppRoute.loginScreen);
    }
  }

  CheckStatus _getCheckStatusFromTrip(TripResponse tripResponse) {
    try {
      if (tripResponse == null || tripResponse.requests.isEmpty) {
        return CheckStatus.empty;
      }
      final currentRequest = tripResponse.requests.first;
      return currentRequest.detail?.status?.toCheckStatus() ??
          CheckStatus.empty;
    } catch (e) {
      logger.e(e);
    }
    return CheckStatus.empty;
  }

  void saveLocationToFireBaseDB(int id, double lat, double lng) {
    String refPath = "loc_p_" + id.toString();
    if (refPath != "loc_p_0")
      try {
        DatabaseReference mLocationRef =
            FirebaseDatabase.instance.reference().child(refPath);
        key = key == null ? mLocationRef.push().key : key;

        if (endLng == 0 || endLat == 0) {
          endLng = lng;
          endLat = lat;
        } else {
          double startLat = endLat;
          endLat = lat;
          double startLng = endLng;
          endLng = lng;

          bearing = LocationHelper.bearingBetweenLocations(
              startLat, startLng, endLat, endLng);
        }
        print("KEY" + mLocationRef.key.toString());

        mLocationRef.set(
            <String, Object>{"lat": endLat, "lng": endLng, "bearing": bearing});
      } catch (e) {
        print("KEY" + e.toString());
      }
  }

  void stopService() {
    _getTripLocked = true;
    _tripSubscription?.cancel();
  }

  void startService(int providerId) {
    registerTripService(providerId);
    _getTripLocked = false;
    getTrip();
  }
}
