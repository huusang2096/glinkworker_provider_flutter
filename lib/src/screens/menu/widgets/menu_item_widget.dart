import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glinkwok_provider/src/common/config.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItemWidget({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          margin: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Center(
            child: FaIcon(icon),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: menuTitleStyle,
          ),
        )
      ],
    );
  }
}
