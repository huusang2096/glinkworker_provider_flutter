import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:simplest/simplest.dart';

class CustomDefaultButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Function press;
  final bool isLoading;
  final double height;
  final Color bgColor;
  final double borderRadius;
  final BorderSide side;

  const CustomDefaultButton(
      {Key key,
      this.text,
      this.textStyle,
      this.press,
      this.isLoading = false,
      this.height = 54.0,
      this.bgColor = primaryColor,
      this.borderRadius = 10.0,
      this.side})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: FlatButton(
        color: bgColor,
        onPressed: isLoading ? () {} : press,
        child: isLoading
            ? SpinKitCircle(
                color: Colors.white,
                size: 36,
              )
            : Text(
                text.tr,
                style: textStyle ?? buttonTextStyle,
              ),
        shape: RoundedRectangleBorder(
          side: side ?? BorderSide(color: primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
