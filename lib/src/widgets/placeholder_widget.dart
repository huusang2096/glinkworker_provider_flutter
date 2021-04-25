import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';

class PlacholderWidget extends StatelessWidget {
  final double size;
  final Color color;
  final Color backgroundColor;

  const PlacholderWidget(
      {Key key, this.size = 60, this.color, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color),
        child: Icon(
          Icons.person,
          color: this.color ?? Colors.grey,
          size: size - 10,
        ));
  }
}
