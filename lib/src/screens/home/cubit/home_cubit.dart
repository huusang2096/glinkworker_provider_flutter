import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/model/cancel_reason_response.dart';
import 'package:glinkwok_provider/src/model/profile_response.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:glinkwok_provider/src/model/update_trip_request.dart';
import 'package:glinkwok_provider/src/model/waiting_time_response.dart';
import 'package:glinkwok_provider/src/screens/menu/menu_item_model.dart';
import 'package:glinkwok_provider/src/services/trip_service.dart';
import 'package:share/share.dart';
import 'package:simplest/simplest.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final locationService = locator<LocationService>();
  final tripService = locator<TripService>();

  @override
  initData() {
    tripService.statusStream.listen((response) {
      _handleChangeFlow(response);
    });
    tripService.startService(appPref.user.id);
  }

  _handleChangeFlow(CheckStatus tripStatus) async {
    logger.d('_handleChangeFlow $tripStatus');
    final _tripResponse = tripService.tripResponse;
    var _polylines = state.polylines;
    // Check to show offline view
    final _isOffline = tripService.accountStatus != AccountStatus.approved ||
        tripService.serviceStatus != ServiceStatus.active;
    if (state.isOffline != _isOffline) {
      emit(ChangeServiceStatusState(_isOffline, _tripResponse, state));
    }
    var newState = state.copyWith(
        isOffline: _isOffline,
        tripResponse: _tripResponse,
        isShowLoading: false);

    switch (tripStatus) {
      case CheckStatus.empty:
        _polylines = {};
        if (!state.isShowSlider || state.isShowLocationHeader) {
          emit(
            ChangeSlider(
              true,
              _tripResponse,
              newState.copyWith(
                  isShowPanel: false,
                  isShowLocationHeader: false,
                  polylines: _polylines),
            ),
          );
        }
        break;
      case CheckStatus.searching:
        _polylines = {};
        emit(IncommingRequestState(
          _tripResponse,
          newState.copyWith(isShowSlider: false, isShowPanel: true),
        ));
        break;
      case CheckStatus.accepted:
        _polylines = await _getPolylines();
        emit(AcceptedTripRequestState(newState.copyWith(
            isShowLocationHeader: true,
            isShowPanel: true,
            polylines: _polylines)));
        break;

        break;
      case CheckStatus.started:
        _polylines = await _getPolylines();
        emit(StartedTripRequestState(newState.copyWith(
            isShowLocationHeader: true,
            isShowSlider: false,
            isShowPanel: true,
            polylines: _polylines)));
        break;
      case CheckStatus.arrived:
        emit(ArrivedState(newState.copyWith(
            isShowLocationHeader: true,
            isShowSlider: false,
            isShowPanel: true)));
        break;
      case CheckStatus.pickedup:
        emit(ServiceDoneState(newState.copyWith(
            isShowLocationHeader: true,
            isShowSlider: false,
            isShowPanel: true)));
        if (state.waitingTimeResponse == null) {
          getWaitingTime(_tripResponse.requests.first.requestId);
        }
        break;
      case CheckStatus.dropped:
        emit(InvoiceState(newState.copyWith(
          isShowPanel: true,
          isShowSlider: false,
        )));
        break;
      case CheckStatus.completed:
        emit(RatingTripState(newState.copyWith(
          isShowPanel: true,
          isShowSlider: false,
        )));
        break;
      case CheckStatus.patch:
        break;
      case CheckStatus.cancelled:
        break;
      case CheckStatus.scheduled:
        break;
    }
  }

  setup() async {
    _handleNotifcation();
    // Init default values
    getCancelReason();
    emit(state.copyWith(user: appPref.user));
  }

  _handleNotifcation() async {
    final _notifService = locator<NotificationService>();
    _notifService.requestPermission();
    log('fcmToken \n ${_notifService.fcmToken}');
    subscriptions.add(_notifService.dataStream.listen((data) {
      logger.i(data);
      tripService.getTrip();
    }));
  }

  logout() {
    appPref.logout();
    tripService.stopService();
    navigator.pushNamedAndRemoveUntil(AppRoute.loginScreen, (route) => false);
  }

  selectMenuItem(MenuItemType menu) async {
    if (menu == MenuItemType.logout) {
      final response = await dialogService.showConfirmationDialog(
          title: kAppName, description: 'are_you_sure_to_logout'.tr);
      if (response.confirmed) {
        logout();
      }
      return;
    }

    switch (menu) {
      case MenuItemType.header:
        return navigator.popAndPushNamed(AppRoute.editProfileScreen);
      case MenuItemType.yourServices:
        return navigator.pushNamed(AppRoute.yourServiceScreen);
      case MenuItemType.wallet:
        return navigator.pushNamed(AppRoute.walletScreen);
      case MenuItemType.summary:
        return navigator.pushNamed(AppRoute.summaryScreen);
      case MenuItemType.earning:
        return navigator.pushNamed(AppRoute.earningScreen);
      case MenuItemType.card:
        return navigator.pushNamed(AppRoute.cardScreen);
      case MenuItemType.settings:
        return navigator.pushNamed(AppRoute.documentScreen);
      case MenuItemType.languages:
        return navigator.pushNamed(AppRoute.languagesScreen);
      case MenuItemType.notification:
        return navigator.pushNamed(AppRoute.notificationScreen);
      case MenuItemType.share:
        String _sharedContent = 'shared_content'.tr + " " + BASE_URL;
        await Share.share(_sharedContent, subject: "subject_mail_shared".tr);
        break;
      case MenuItemType.help:
        return navigator.pushNamed(AppRoute.helpScreen);
      case MenuItemType.logout:
        // TODO: Handle this case.
        break;
    }
  }

  toggleProviderStatus() async {
    final _isActive = tripService.serviceStatus == ServiceStatus.active;
    try {
      emit(state.copyWith(isShowLoading: true));
      final _updateStatus =
          _isActive ? ServiceStatus.offline : ServiceStatus.active;
      await dataRepository.providerAvailable(describeEnum(_updateStatus));
      await tripService.getTrip();
    } catch (e) {
      logger.e(e);
      handleAppError(e);
    }
    emit(state.copyWith(isShowLoading: false));
  }

  cancelTrip(String reason) async {
    final isConfirmed = (await dialogService
            .showConfirmationDialog(
                title: kAppName,
                description: 'are_you_sure_to_cancel'.tr,
                cancelTitle: 'no'.tr,
                confirmationTitle: 'yes'.tr)
            .whenComplete(() => navigator.pop()))
        .confirmed;
    if (!isConfirmed) {
      return;
    }
    logger.d('---- cancelTrip');
    // TODO: Add cancel reasons list
    emit(state.copyWith(isShowLoading: true));
    try {
      final _tripRequestDetail = state.tripResponse.requests.first.detail;
      await dataRepository.cancelRequest(_tripRequestDetail.id, reason);
      await tripService.getTrip();
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isShowLoading: false));
  }

  requestLocation() async {
    await locationService.fetchLocation(askPermission: true);
    emit(HomeUpdateLocation(locationService.position, state));
  }

  recheck() {
    tripService.getTrip();
  }

  rejectTripRequest() async {
    try {
      emit(state.copyWith(isShowLoading: true));
      final tripRequest = state.tripResponse.requests.first;
      await dataRepository.rejectRequest(tripRequest.requestId);
      locator<SnackbarService>().showSnackbar(message: 'request_cancelled'.tr);
      await tripService.getTrip();
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isShowLoading: false));
  }

  acceptTripRequest() async {
    try {
      emit(state.copyWith(isShowLoading: true));
      final tripRequest = state.tripResponse.requests.first;
      await dataRepository.acceptRequest(requestId: tripRequest.requestId);
      await tripService.getTrip();
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isShowLoading: false));
  }

  _updateStripStatus(CheckStatus newStatus) async {
    try {
      emit(state.copyWith(isShowLoading: true));
      final status = describeEnum(newStatus).toUpperCase();
      final tripRequest = state.tripResponse.requests.first;
      final updateRequest = UpdateTripRequest(
        requestId: tripRequest.requestId,
        status: status,
        method: 'PATCH',
        latitude: locationService.position.latitude,
        longitude: locationService.position.longitude,
      );
      if (newStatus == CheckStatus.completed) {
        final _type = tripRequest.detail.paymentMode.toPaymentType();
        switch (_type) {
          case PaymentType.CASH:
            updateRequest.paymentMode = describeEnum(_type);
            break;
          case PaymentType.DEBIT_MACHINE:
            updateRequest.paymentMode = describeEnum(_type);
            break;
          case PaymentType.VOUCHER:
            updateRequest.paymentMode = describeEnum(_type);
            break;
          case PaymentType.CARD:
            updateRequest.paymentMode = describeEnum(_type);
            updateRequest.paymentType = describeEnum(_type);
            updateRequest.tips = 0.0;
            break;
        }
      }
      await dataRepository.updateRequest(
          requestId: tripRequest.requestId, request: updateRequest);
      if (newStatus == CheckStatus.pickedup) {
        startWaitingTime();
      }
      if (newStatus == CheckStatus.dropped) {
        stopWaitingTime();
      }
      await tripService.getTrip();
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isShowLoading: false));
  }

  onSelectArrived() async {
    _updateStripStatus(CheckStatus.arrived);
  }

  onStartService() async {
    _updateStripStatus(CheckStatus.pickedup);
  }

  onCancel() async {
    _updateStripStatus(CheckStatus.cancelled);
  }

  serviceDone() {
    _updateStripStatus(CheckStatus.dropped);
  }

  confirmPayment() {
    _updateStripStatus(CheckStatus.completed);
  }

  startWaitingTime() async {
    try {
      WaitingTimeResponse waitingTimeResponse = await dataRepository
          .waitingTime(state.tripResponse.requests.first.requestId, "1");
      waitingTimeResponse.waitingTime = 0;
      emit(WaitingTimeResponseState(waitingTimeResponse, state));
    } catch (e) {
      print(e);
    }
  }

  stopWaitingTime() async {
    try {
      WaitingTimeResponse waitingTimeResponse = await dataRepository
          .waitingTime(state.tripResponse.requests.first.requestId, "0");
      waitingTimeResponse.waitingTime = 0;
      emit(WaitingTimeResponseState(waitingTimeResponse, state));
    } catch (e) {
      print(e);
    }
  }

  getWaitingTime(int id) async {
    try {
      WaitingTimeResponse waitingTimeResponse =
          await dataRepository.checkWaitingTime(id);
      emit(WaitingTimeResponseState(
        waitingTimeResponse,
        state,
      ));
    } catch (e) {
      print(e);
    }
  }

  submitRatingTrip(double rating, String comment) async {
    emit(state.copyWith(isShowLoading: true));
    try {
      final _tripRequest = state.tripResponse.requests.first;
      await dataRepository.ratingRequest(
          requestId: _tripRequest.requestId,
          rating: rating.round(),
          comment: comment);
      await tripService.getTrip();
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isShowLoading: false));
  }

  selectRequestLocation() {
    final _request = state.tripResponse.requests.first.detail;
    final position =
        Position(latitude: _request.sLatitude, longitude: _request.sLongitude);
    emit(MoveToPositionState(position, state));
  }

  _getPolylines() async {
    Set<Polyline> _polylines = {};
    final _currentPosition = locationService.position;

    if ((state.tripResponse?.requests?.length ?? 0) > 0 &&
        _currentPosition.latitude != 0) {
      final _tripRequest = state.tripResponse.requests.first;

      final polyResult = await PolylinePoints().getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
        PointLatLng(
            _tripRequest.detail.sLatitude, _tripRequest.detail.sLongitude),
      );
      final _points = (polyResult.points
          .map((point) => LatLng(point.latitude, point.longitude))).toList();
      final _polylineSource = Polyline(
          width: 5, // set the width of the polylines
          polylineId: PolylineId(_tripRequest.requestId.toString()),
          color: Colors.redAccent,
          points: _points);
      _polylines.add(_polylineSource);
    }
    return _polylines;
  }

  onSelectCalling() async {
    final _requests = state.tripResponse.requests;
    if (_requests.length == 0) {
      return;
    }
    final _user = _requests.first.detail.user;
    final url = 'tel:${_user.countryCode}${_user.mobile}';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      logger.e('Can not launch url $url');
    }
  }

  onSelectSOS() async {
    final url = 'tel:$kSupportNumber';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      logger.e('Can not launch url $url');
    }
  }

  onSelectChat() async {
    final _requests = state.tripResponse.requests;
    if (_requests.length == 0) {
      return;
    }
    final _currentTrip = _requests.first;
    navigator.pushNamed(AppRoute.chatScreen,
        arguments: {'tripRequest': _currentTrip});
  }

  getCancelReason() async {
    try {
      final cancelReason = await dataRepository.getCancelReason();
      emit(state.copyWith(cancelReason: cancelReason));
    } catch (e) {
      logger.e(e);
    }
  }

  selectCancelReason(int index) {
    emit(SelectCancelReason(index, state));
  }

  handleDismissCancelRequest() {
    recheck();
  }
}
