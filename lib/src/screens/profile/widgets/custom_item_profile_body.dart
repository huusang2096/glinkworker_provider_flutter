import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:simplest/simplest.dart';

class CustomItemProfileBody extends StatelessWidget {
  final Function onPress;
  final String imgAsset;
  final String textKey;
  final double paddingTop;

  const CustomItemProfileBody(
      {Key key, this.onPress, this.imgAsset, this.textKey, this.paddingTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          SizedBox(
            height: paddingTop,
          ),
          Row(
            children: [
              SvgPicture.asset(imgAsset),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  textKey.tr,
                  style: body1.apply(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
