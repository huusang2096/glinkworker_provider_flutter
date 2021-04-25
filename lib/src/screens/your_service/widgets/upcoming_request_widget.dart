import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/your_service/cubit/service_cubit.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_ongoing_trip_response_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/widgets/build_ongoing_request_item_card_widget.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class HisoryUpcomingWidget extends StatelessWidget {
  ServiceCubit _cubit;
  @override
  Widget build(BuildContext context) {
    _cubit = context.watch<ServiceCubit>();
    List<ProviderOngoingTripDetailResponse> ongoingTrips =
        _cubit.state.upcomingTrips;

    bool _isTripEmpty = (ongoingTrips ?? []).isEmpty;
    if (_cubit.state.isLoading) {
      return SpinKitCircle(
        color: Colors.grey,
        size: 36.0,
      );
    }
    if (_isTripEmpty) {
      return SingleChildScrollView(
        child: Container(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Images.logo.loadImage(height: 72),
              SizedBox(
                height: 50,
              ),
              Text(
                "empty_schedule".tr,
                style: body1.copyWith(fontSize: 15),
              ),
            ],
          ),
        )),
      );
    } else {
      return SingleChildScrollView(
          child: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 15),
          itemCount: ongoingTrips.length,
          itemBuilder: (context, index) {
            return OngoingCardItemWidget(ongoingTrips[index] ?? '');
          },
        ),
      ));
    }
  }
}
