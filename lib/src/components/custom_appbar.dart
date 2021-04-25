import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/style.dart';

class AppbarWidget extends StatelessWidget {
  final String text;

  const AppbarWidget({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: blackColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        text,
        style: heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
