import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/components/custom_appbar.dart';
import 'package:glinkwok_provider/src/model/wallet_transaction_response_model.dart';
import 'package:glinkwok_provider/src/screens/wallet/cubit/wallet_cubit.dart';
import 'package:glinkwok_provider/src/screens/wallet/widgets/text_input_widget.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class WalletScreen extends CubitWidget<WalletCubit, WalletState> {
  TextEditingController _txtController = TextEditingController();
  List<WalletTransation> walletTransactions = new List<WalletTransation>();

  static provider() {
    return BlocProvider(
      create: (_) => WalletCubit(),
      child: WalletScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getWalletTransaction();
  }

  @override
  Widget builder(BuildContext context, WalletState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: AppbarWidget(
          text: "wallet".tr,
        ),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeaderContent(context),
          SizedBox(
            height: 40,
          ),
          // _buildAddAmount(context),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: _buildDepositContent(context),
          )
        ],
        /*),*/
      ),
    );
  }

  _buildHeaderContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(Images.wallet_icon),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "your_wallet_amount".tr,
              style: heading1.copyWith(fontSize: 15, color: greyColor),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: bloc.state.isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitThreeBounce(
                        color: Colors.red,
                        size: 26.0,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          '${bloc.state.wallet?.walletBalance?.toString() ?? ""} $kCurrency',
                          style: heading1.copyWith(
                            color: Colors.red,
                            fontSize: 30,
                          ),
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }

  // _buildAddAmount(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 20, right: 20),
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: whiteColor,
  //         border: Border.all(width: 1, color: Colors.grey),
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.4),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: Offset(0, 3), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'enter_amount'.tr,
  //             style: body1.copyWith(fontSize: 20),
  //           ),
  //           InputTextField(
  //             suffixIconText: 'add_amount',
  //             placeholder: "100",
  //             inputType: TextInputType.number,
  //             controller: _txtController,
  //             suffixOntap: () {
  //               if (_txtController.text.toString().length == 0 ||
  //                   _txtController.text == null) {
  //               } else {}
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _buildDepositContent(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: greyColor)),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Stack(
          children: <Widget>[
            _buildListDeposit(context),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: redColor2, borderRadius: BorderRadius.circular(5)),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Text(
                        "transaction_id".tr,
                        style: textStyleWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                      child: Text("date".tr, style: textStyleWhite),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 10),
                      child: Text("amount".tr, style: textStyleWhite),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  _buildListDeposit(BuildContext context) {
    if (bloc.state.wallet == null) {
      return SpinKitCircle(
        color: Colors.grey,
        size: 36.0,
      );
    } else if (bloc.state.wallet.walletTransation.length == 0) {
      return Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: greyColor)),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Text(
          'no_wallet_history'.tr,
          style: body1.copyWith(color: redColor2),
        ),
      );
    } else {
      walletTransactions = bloc.state.wallet.walletTransation;
      return ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: walletTransactions.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: Text(
                    walletTransactions[index].transactionAlias,
                    textAlign: TextAlign.center,
                    style: body1,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    walletTransactions[index].createdAt.toString(),
                    textAlign: TextAlign.center,
                    style: body1,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '${walletTransactions[index].amount?.toString() ?? ''} $kCurrency',
                      textAlign: TextAlign.center,
                      style:
                          walletTransactions[index].transactions[0].type == "D"
                              ? body1.copyWith(color: Colors.red)
                              : body1.copyWith(color: Colors.green),
                    ),
                    padding: EdgeInsets.only(top: 10),
                  ),
                ),
              ],
            );
          });
    }
  }
}
