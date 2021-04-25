import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/services/trip_service.dart';
import 'package:simplest/simplest.dart';

class PannelInvoice extends StatelessWidget {
  Widget _getImageType(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.CASH:
        return FaIcon(
          FontAwesomeIcons.moneyBill,
          color: Colors.green,
        );
        break;
      case PaymentType.DEBIT_MACHINE:
        return FaIcon(
          FontAwesomeIcons.creditCard,
          color: Colors.grey,
        );
        break;
      case PaymentType.VOUCHER:
        return FaIcon(
          FontAwesomeIcons.creditCard,
          color: Colors.deepOrange,
        );
        break;
      case PaymentType.CARD:
        return FaIcon(
          FontAwesomeIcons.creditCard,
          color: Colors.blue,
        );
    }
    return SizedBox.shrink();
  }

  Widget _amountWidget(Payment payment) {
    var _payable = payment?.payable ?? 0;
    if (_payable == 0) {
      return SizedBox.shrink();
    }

    var _amount = '';
    if (payment.paymentMode == 'CASH') {
      _amount = currencyFormatter.format(payment.providerPay);
    } else {
      _amount = currencyFormatter.format(_payable);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "amount_to_be_paid".tr,
        style: body1.copyWith(fontWeight: FontWeight.bold),
      ),
      Text(_amount, style: body1.copyWith(fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _taxWidget(Payment payment) {
    var _tax = payment?.tax ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('tax'.tr, style: body1),
        Text(
          "$_tax",
          style: body1,
        )
      ],
    );
  }

  Widget _fixedWidget(Payment payment) {
    var _fixed = payment?.fixed ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('fixed'.tr, style: body1),
        Text(
          "$_fixed",
          style: body1,
        )
      ],
    );
  }

  Widget _discountWidget(Payment payment) {
    var _discount = payment?.discount ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('discount'.tr, style: body1),
        Text(
          "$_discount",
          style: body1,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<HomeCubit>();
    final _tripRequest = bloc.state.tripResponse.requests.first;
    final _payment = _tripRequest.detail.payment;
    final _paymentType = _tripRequest.detail.paymentMode.toPaymentType();
    final _imgPayment = _getImageType(_paymentType);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            alignment: Alignment.center,
            child: Text(
              "invoice".tr,
              style: heading18Black,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "booking_id".tr,
              style: body1,
            ),
            Text(_tripRequest.detail.bookingId, style: body1),
          ]),
          SizedBox(
            height: 8,
          ),
          _fixedWidget(_payment),
          _taxWidget(_payment),
          _discountWidget(_payment),
          _amountWidget(_payment),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 2,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              _imgPayment,
              SizedBox(
                width: 8,
              ),
              Text(
                describeEnum(_paymentType).tr,
                style: headingBlack,
              ),
            ],
          ),
          InkWell(
            onTap: bloc.confirmPayment,
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: redColor2, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "confirm_payment".tr,
                style: body1.copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
