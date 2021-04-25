import 'package:flutter/material.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';

part 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final isUserExist = appPref.token.isNotEmpty;
    if (isUserExist) {
      navigator.replaceWith(AppRoute.homeScreen);
    } else {
      navigator.replaceWith(AppRoute.loginScreen);
    }
  }
}
