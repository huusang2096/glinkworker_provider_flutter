import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:credit_card_field/credit_card_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/card/cubit/cubit/card_cubit.dart';
import 'package:simplest/simplest.dart';
import 'package:stripe_payment/stripe_payment.dart';

class AddCardScreen extends CubitWidget<CardCubit, CardState> {
  final int amount;
  TextEditingController _txtCardNumber;
  TextEditingController _txtExpriratonDateController;
  // final dateFormat = new DateFormat('yyyy-MM');
  TextEditingController _txtCvvController;
  Token stripeToken;
  CreditCard creditCard;

  //key for validator form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddCardScreen({this.amount});

  static provider({int amount, bool requestGoto}) {
    return BlocProvider<CardCubit>(
      create: (context) => CardCubit(),
      child: AddCardScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _txtCardNumber = new TextEditingController();
    _txtExpriratonDateController = new TextEditingController();
    _txtCvvController = new TextEditingController();
    creditCard = new CreditCard();
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_PMYaUNmrK3jo5j4juAV282vy",
        merchantId: "Test", //YOUR_MERCHANT_ID
        androidPayMode: 'test'));
  }

  @override
  void listener(BuildContext context, CardState state) {
    super.listener(context, state);
    if (state is AddCardSuccesState) {
      _showDialogConfirm(context, state.message);
    }
  }

  @override
  Widget builder(BuildContext context, CardState state) {
    return Scaffold(
        appBar: AppBar(
          title: Text('add_card'.tr),
          // automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: _buildBody(context),
        ));
  }

  _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 60,
                  child: Icon(
                    Icons.payment_outlined,
                    size: 25,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 100,
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? "card_number_cannot_null".tr : null,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 16,
                    controller: _txtCardNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'card_number'.tr,
                        labelStyle: body1.copyWith(color: Colors.grey)),
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 100,
                  child: ExpirationFormField(
                    decoration: InputDecoration(
                      labelText: 'expiration_date'.tr,
                      hintText: "MM/YY",
                      labelStyle: body1.copyWith(color: Colors.grey),
                    ),
                    controller: _txtExpriratonDateController,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 100,
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? "cvv_cannot_null".tr : null,
                    maxLength: 3,
                    controller: _txtCvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'ccv'.tr,
                        labelStyle: body1.copyWith(color: Colors.grey)),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  if (_txtCardNumber.text.isNotEmpty &&
                      _txtExpriratonDateController.text.isNotEmpty &&
                      _txtCvvController.text.isNotEmpty) {
                    creditCard.number = _txtCardNumber.text.toString();
                    //Get expriration month
                    creditCard.expMonth = int.tryParse(
                        _txtExpriratonDateController.text.substring(0, 2));
                    //Get expriration year
                    creditCard.expYear = int.tryParse(
                        _txtExpriratonDateController.text.substring(3, 5));
                    creditCard.cvc = _txtCvvController.text.toString();
                    //create token with card using stripe api
                    StripePayment.createTokenWithCard(
                      creditCard,
                    ).then((token) {
                      bloc.addCard(token.tokenId);
                    }).catchError(setError);
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      color: redColor2,
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.center,
                  child: Text(
                    'submit'.tr,
                    style: body1.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//show error by stripe
  void setError(dynamic error) {
    String newError = error.toString().replaceAll(RegExp('\\('), '');
    String newError2 = newError.split(',')[1].toString();
    bloc.showErrorMessage(newError2.toString());
  }

  _showDialogConfirm(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Glink Work"),
            content: Text(message),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop({'amount': amount});
                  },
                  child: Text("Ok")),
            ],
          );
        });
  }
}
