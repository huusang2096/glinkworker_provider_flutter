import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/components/custom_card_summary.dart';
import 'package:glinkwok_provider/src/screens/summary/cubit/summary_cubit.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class SummaryScreen extends CubitWidget<SummaryCubit, SummaryState> {
  static provider() {
    return BlocProvider(
      create: (_) => SummaryCubit(),
      child: SummaryScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    bloc.getSummary();
  }

  @override
  Widget builder(BuildContext context, SummaryState state) {
    return AppProgressHUB(
      inAsyncCall: state.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("summary".tr),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                children: [
                  CustomCardSummary(
                    text: "revenue",
                    color: Colors.blue,
                    value: "${state.summaryResponse?.revenue ?? '0'}",
                    image: FontAwesomeIcons.coins, //SvgPicture not Image
                    currency: kCurrency,
                  ),
                  CustomCardSummary(
                    text: "revenue_of_the_month",
                    color: Colors.green,
                    value: "${state.summaryResponse?.montlyGains ?? '0'}",
                    image: FontAwesomeIcons.history, //SvgPicture not Image
                    currency: kCurrency,
                  ),
                  CustomCardSummary(
                    text: "monthly_pass",
                    color: Colors.yellow,
                    value: "${state.summaryResponse?.montlyPass ?? '0'}",
                    image:
                        FontAwesomeIcons.moneyCheckAlt, //SvgPicture not Image
                    currency: kCurrency,
                  ),
                  CustomCardSummary(
                    text: "total_no_of_service",
                    color: Colors.deepOrange,
                    value: "${state.summaryResponse?.rides ?? '0'}",
                    image: FontAwesomeIcons.rocket, //SvgPicture not Image
                    currency: "",
                  ),
                  CustomCardSummary(
                    text: "complete_travel",
                    color: Colors.purple,
                    value: "${state.summaryResponse?.completedRides ?? '0'}",
                    image: FontAwesomeIcons
                        .solidCheckCircle, //SvgPicture not Image
                    currency: "",
                  ),
                  CustomCardSummary(
                    text: "canceled_service",
                    color: Colors.red,
                    value: "${state.summaryResponse?.cancelRides ?? '0'}",
                    image: FontAwesomeIcons.xbox, //SvgPicture not Image
                    currency: "",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
