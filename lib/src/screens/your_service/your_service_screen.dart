import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/your_service/widgets/ongoing_request_widget.dart';
import 'package:glinkwok_provider/src/screens/your_service/widgets/upcoming_request_widget.dart';
import 'package:glinkwok_provider/src/screens/your_service/widgets/past_request_widget.dart';

import 'package:simplest/simplest.dart';

import 'cubit/service_cubit.dart';

class YourServiceScreen extends CubitWidget<ServiceCubit, ServiceState> {
  static provider() {
    return BlocProvider<ServiceCubit>(
      create: (_) => ServiceCubit(),
      child: YourServiceScreen(),
    );
  }

  @override
  Widget builder(BuildContext context, ServiceState state) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppbar(context),
        body: TabBarView(
          children: [
            HisoryOngoingWidget(),
            HisoryUpcomingWidget(),
            HisoryPastWidget()
          ],
        ),
      ),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      centerTitle: false,
      leading: null,
      elevation: 0,
      title: Text(
        ('order_history').tr,
        style: heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
      backgroundColor: whiteColor,
      bottom: PreferredSize(
          preferredSize: Size(700, 80),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0XFFf5f5f5),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.transparent,
                  indicator: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: whiteColor),
                  indicatorWeight: 0.0,
                  unselectedLabelColor: blackColor,
                  labelColor: blackColor,
                  labelStyle: textStyleWhite,
                  unselectedLabelStyle: textStyleWhite,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        ('ongoing').tr,
                        style: body1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        ('schedule').tr,
                        style: body1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        ('past').tr,
                        style: body1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    bloc.getProivderTrips();
  }

  @override
  void listener(BuildContext context, ServiceState state) {
    super.listener(context, state);
    if (state is CancelTripState) {
      bloc.refreshData();
    }
  }
}
