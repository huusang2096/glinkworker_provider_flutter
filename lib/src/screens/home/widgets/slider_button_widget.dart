import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:slider_button/slider_button.dart';

class SliderButtonWidet extends StatelessWidget {
  final String label;
  final Function action;
  final double height;
  final double width;
  final Color backgroundColor;

  const SliderButtonWidet(
      {Key key,
      this.label,
      this.height = 70,
      this.width,
      this.action,
      this.backgroundColor = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderButton(
      height: this.height,
      dismissible: false,
      width: this.width,
      vibrationFlag: false,
      action: action,
      shimmer: false,
      backgroundColor: this.backgroundColor,
      alignLabel: Alignment.center,
      label: Text(
        label,
        style: body1.copyWith(color: Colors.white),
      ),
    );
  }
}
