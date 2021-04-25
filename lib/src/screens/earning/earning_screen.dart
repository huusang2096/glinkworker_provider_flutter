import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/components/custom_appbar.dart';
import 'package:glinkwok_provider/src/model/ride_response.dart';
import 'package:glinkwok_provider/src/screens/earning/cubit/earning_cubit.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:simplest/simplest.dart';

class EarningScreen extends CubitWidget<EarningCubit, EarningState> {
  static provider() {
    return BlocProvider(
      create: (_) => EarningCubit(),
      child: EarningScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getEarning();
  }

  Widget _buildBody(BuildContext context, EarningState state) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          CircularPercentIndicator(
            radius: 180.0,
            lineWidth: 18.0,
            animation: true,
            percent: state.percent,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.rideResponse == null
                      ? "0/20"
                      : state.rideResponse.rides.length.toString() +
                          "/" +
                          state.rideResponse.target.toString(),
                  style: new TextStyle(
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      fontSize: 24.0),
                ),
                Text(
                  'target'.tr,
                  style: new TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                ),
              ],
            ),
            footer: Column(
              children: [
                Text(
                  'total_earning'.tr,
                  style: new TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16.0),
                ),
                Text(
                  currencyFormatter.format(state.total ?? 0),
                  style: new TextStyle(
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      fontSize: 24.0),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: primaryColor,
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Text(
                    'time'.tr,
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
                new Positioned(
                  child: new Align(
                    alignment: FractionalOffset.center,
                    child: Text(
                      'distance'.tr,
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Text(
                    'amount'.tr,
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
                itemBuilder: (_, index) =>
                    _itemWidget(state.rideResponse.rides[index]),
                separatorBuilder: (_, index) => Container(
                      height: 16.0,
                    ),
                itemCount: state.rideResponse == null
                    ? 0
                    : state.rideResponse.rides.length),
          )
        ],
      ),
    );
  }

  Widget _itemWidget(Ride ride) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                offset: Offset(0, 10),
                blurRadius: 20)
          ]),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Text(
              hourFormatter.format(ride.finishedAt),
              style: new TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
              textAlign: TextAlign.left,
            ),
          ),
          new Positioned(
            child: new Align(
              alignment: FractionalOffset.center,
              child: Text(
                ride.payment.distance.toString() + " KM",
                style: new TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Text(
              currencyFormatter.format(ride.payment?.providerPay ?? 0),
              style: new TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: AppbarWidget(
        text: 'earning'.tr,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  @override
  Widget builder(BuildContext context, EarningState state) {
    return AppProgressHUB(
      inAsyncCall: state.isLoading,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context, state),
      ),
    );
  }
}
