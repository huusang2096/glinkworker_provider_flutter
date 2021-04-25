import 'package:flutter/material.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/services/trip_service.dart';
import 'package:simplest/simplest.dart';

class HomeAccountWidget extends StatelessWidget {
  Widget _buildActionForState(
      BuildContext context, HomeCubit bloc, HomeState state) {
    final accountStatus = bloc.tripService.accountStatus;
    final _titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    final _space = 10.0;
    var _title = 'account_verification_desc'.tr;
    var _onSelect = () => bloc.recheck();
    if (accountStatus == AccountStatus.document) {
      _title = 'please_fill_documents'.tr;
      _onSelect = () => Navigator.pushNamed(context, AppRoute.documentScreen);
    }

    if (accountStatus == AccountStatus.card) {
      _title = 'please_fill_credit_card'.tr;
      _onSelect = () => Navigator.pushNamed(context, AppRoute.cardScreen);
    }

    if (accountStatus == AccountStatus.balance) {
      _title = 'low_balance'.tr;
      _onSelect = () => Navigator.pushNamed(context, AppRoute.walletScreen);
    }

    if (accountStatus == AccountStatus.banned) {
      _title = 'banned_desc'.tr;
    }

    if (accountStatus == AccountStatus.onboarding) {
      _title = 'account_verification_desc'.tr;
    }

    if (accountStatus == AccountStatus.approved) {
      final avatar = state.user?.avatar ?? '';
      if (avatar.isEmpty) {
        _title = 'please_add_selfie'.tr;
        _onSelect =
            () => Navigator.pushNamed(context, AppRoute.editProfileScreen);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _title,
            style: _titleStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: _space,
          ),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: primaryColor,
                child: Text(
                  'ok'.tr,
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                onPressed: _onSelect,
              ))
        ],
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<HomeCubit>();
    if (!bloc.state.isOffline ||
        bloc.tripService.accountStatus == AccountStatus.approved) {
      return SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: _buildActionForState(context, bloc, bloc.state),
    );
  }
}
