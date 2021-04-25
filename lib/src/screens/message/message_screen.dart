import 'package:flutter/material.dart';


class MessageScreen extends StatelessWidget {

  static provider(){
    return MessageScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox.expand(
          child: Center(
            child:Text('MessageScreen')
          ),
        ),
      ),
    );
  }
}
