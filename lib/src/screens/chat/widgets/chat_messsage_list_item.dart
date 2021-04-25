import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/model/chat.dart';

class ChatMessageListItem extends StatelessWidget {
  Chat chat;
  final Animation animation;

  ChatMessageListItem({this.chat, this.animation});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: chat.sender == 'provider'
          ? getSentMessageLayout(context)
          : getReceivedMessageLayout(context),
    );
  }

  Widget getSentMessageLayout(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(chat.text),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                //  Container(
                //     margin: const EdgeInsets.only(left: 8.0),
                //     child:  CircleAvatar(
                //       backgroundImage: AssetImage(this.chat.user.avatar),
                //     )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getReceivedMessageLayout(context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  Container(
                //     margin: const EdgeInsets.only(right: 8.0),
                //     child:  CircleAvatar(
                //       backgroundImage: AssetImage(this.chat.user.avatar),
                //     )),
              ],
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      chat.text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
