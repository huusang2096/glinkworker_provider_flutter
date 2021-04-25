import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/splash/cubit/splash_cubit.dart';

import 'package:simplest/simplest.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  static provider() {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: SplashScreen(),
    );
  }
}

class _SplashScreenState
    extends CubitState<SplashScreen, SplashCubit, SplashState>
    with SingleTickerProviderStateMixin {
  Animation animation,
      delayedAnimation,
      muchDelayAnimation,
      transfor,
      fadeAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    transfor = BorderRadiusTween(
            begin: BorderRadius.circular(125.0),
            end: BorderRadius.circular(0.0))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.ease));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.loadData();
  }

  @override
  Widget builder(BuildContext context, SplashState state) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: new Container(
              decoration: new BoxDecoration(color: Colors.white),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Flexible(
                    flex: 1,
                    child: new Center(
                        child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Images.logo.loadImage(height: 100),
                    )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
