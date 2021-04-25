import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/your_service/cubit/past_service_cubit.dart';
import 'package:glinkwok_provider/src/screens/your_service/cubit/service_cubit.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_past_trip_response_model.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'build_past_request_item_card_widget.dart';
import 'package:simplest/simplest.dart';

class HisoryPastWidget extends StatelessWidget {
  ServiceCubit _cubit;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    _cubit = context.watch<ServiceCubit>();
    List<ProviderPastTripResponse> pastTrips = _cubit.state.pastTrips;
    Widget content;

    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _cubit.refreshData();
      _refreshController.refreshCompleted();
    }

    bool isTripEmpty = (pastTrips ?? []).isEmpty;
    if (_cubit.state.isLoading) {
      return SpinKitCircle(
        color: Colors.grey,
        size: 36.0,
      );
    }
    if (isTripEmpty) {
      content = SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                    "empty".tr,
                    style: body1.copyWith(fontSize: 15),
                  ),
                ],
              ),
            )),
      );
    } else {
      content = ListView.builder(
        padding: EdgeInsets.only(bottom: 15),
        itemCount: pastTrips.length,
        itemBuilder: (context, index) {
          return PastCardItemWidget(pastTrips[index]);
        },
      );
    }
    return _cubit.state.isLoading
        ? Center(child: CircularProgressIndicator())
        : SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            child: content,
          );
  }
}
