import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/model/chat.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:glinkwok_provider/src/screens/chat/cubit/chat_cubit.dart';
import 'package:simplest/simplest.dart';

import 'widgets/chat_messsage_list_item.dart';

class ChatScreen extends CubitWidget<ChatCubit, ChatState> {
  static provider(TripRequest tripRequest) {
    return BlocProvider(
      create: (context) => ChatCubit(tripRequest: tripRequest),
      child: ChatScreen(),
    );
  }

  final _listKey = GlobalKey<AnimatedListState>();
  final _textController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.loadChat();
  }

  @override
  Widget builder(BuildContext context, ChatState state) {
    return Scaffold(
      body: _buildBody(context, state),
    );
  }

  _buildBody(BuildContext context, ChatState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: AnimatedList(
                key: _listKey,
                reverse: true,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                initialItemCount: state.chatList.length,
                itemBuilder: (context, index, Animation<double> animation) {
                  Chat chat = state.chatList[index];
                  return ChatMessageListItem(
                    chat: chat,
                    animation: animation,
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey.withOpacity(0.3)))),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: 'enter_message'.tr,
                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.8)),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.only(right: 30),
                    onPressed: () => bloc.send(_textController.text),
                    icon: FaIcon(
                      FontAwesomeIcons.paperPlane,
                      color: Theme.of(context).accentColor,
                      size: 30,
                    ),
                  ),
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void listener(BuildContext context, ChatState state) {
    super.listener(context, state);
    if (state is ChatAddedState) {
      _listKey.currentState.insertItem(0);
      _textController.text = '';
    }
  }
}
