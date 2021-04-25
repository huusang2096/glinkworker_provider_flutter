import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/components/custom_appbar.dart';
import 'package:glinkwok_provider/src/screens/card/cubit/cubit/card_cubit.dart';
import 'package:simplest/simplest.dart';

class CardScreen extends CubitWidget<CardCubit, CardState> {
  static provider() => BlocProvider(
        create: (context) => CardCubit(),
        child: CardScreen(),
      );

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getCardPayment();
  }

  @override
  Widget builder(BuildContext context, CardState state) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppbarWidget(
          text: ("card").tr,
        ),
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child: Text(
              "card_payment".tr,
              style: heading1,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          _buildListCard(context),
          SizedBox(
            height: 50,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.addCardScreen)
                  .then((value) => bloc.getCardPayment());
            },
            color: primaryColor,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "add_change_card".tr,
                style: body1.copyWith(color: Colors.white),
              ),
            ),
            height: 50,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
          )
        ],
      ),
    );
  }

  _buildListCard(BuildContext context) {
    if (bloc.state.card == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (bloc.state.card.length == 0) {
      return SizedBox();
    } else if (bloc.state.card != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: bloc.state.card.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                /* userAddMoneyRequest.cardId = bloc.state.card[index].cardId;
                _showDialogConfirm(context);*/
              },
              onTap: () {
                /* if (requestGoto) {
                  Navigator.of(context)
                      .pop({'card': bloc.state.card[index]});
                } else {
                   userAddMoneyRequest.cardId =
                      bloc.state.card[index].cardId;
                  userAddMoneyRequest.amount = amount;
                  bloc.addMoney(userAddMoneyRequest);
                }*/
              },
              title: Text(
                "XXXX-XXXX-XXXX-" + bloc.state.card[index].lastFour,
                style: body1,
              ),
              trailing: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.addCardScreen)
                      .then((value) => bloc.getCardPayment());
                },
                child: Text(
                  "change".tr,
                  style: body1,
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
