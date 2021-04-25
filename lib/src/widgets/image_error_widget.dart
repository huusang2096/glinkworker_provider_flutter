import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';

class ImageErrorWidget extends StatelessWidget {
  final double size;

  const ImageErrorWidget({Key key, this.size = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        child: Icon(
          Icons.person,
          size: size - 10,
        ));
  }
}
