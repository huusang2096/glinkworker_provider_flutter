import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/your_service/cubit/service_cubit.dart';
import 'package:glinkwok_provider/src/services/trip_service.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

import 'build_ongoing_trip_card_widget.dart';

class HisoryOngoingWidget extends StatelessWidget {
  ServiceCubit _cubit;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    _cubit = context.watch<ServiceCubit>();

    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _cubit.refreshData();
      _refreshController.refreshCompleted();
    }

    TripService tripService = locator<TripService>();
    bool isEmpty = (tripService.tripResponse?.requests ?? []).isEmpty;
    Widget contentWidget = SizedBox.shrink();
    if (_cubit.state.isLoading) {
      return SpinKitCircle(
        color: Colors.grey,
        size: 36.0,
      );
    }
    if (isEmpty) {
      contentWidget = SingleChildScrollView(
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
              "empty_ongoing".tr,
              style: body1.copyWith(fontSize: 15),
            ),
          ],
        ),
      ));
    } else {
      contentWidget = OngoingTripCard(tripService.tripResponse, _cubit);
    }
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: _onRefresh,
      child: contentWidget,
    );
  }
}
