import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/config.dart';

class CustomSocialCard extends StatelessWidget {
  final Color color;
  final IconData iconData;

  const CustomSocialCard({Key key, this.color, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        50.0,
      ),
      child: InkWell(
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(
          50.0,
        ),
        onTap: () {
          print("Facebook on tap");
        },
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50.0,
            ),
            border: Border.all(width: 2.0, color: color), //Color
          ),
          child: Center(
            child: FaIcon(
              iconData, //IconData
              color: facebook,
            ),
          ),
        ),
      ),
    );
  }
}
