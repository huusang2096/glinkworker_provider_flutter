part of 'chat_cubit.dart';

class ChatState {
  TripRequest tripRequest;
  List<Chat> chatList;

  ChatState({@required this.tripRequest, this.chatList});

  ChatState copyWith({TripRequest tripRequest, List<Chat> chatList}) {
    return ChatState(
        tripRequest: tripRequest ?? this.tripRequest,
        chatList: chatList ?? this.chatList);
  }

  ChatState.from(ChatState state) {
    this.tripRequest = state.tripRequest;
    this.chatList = state.chatList;
  }
}

class ChatInitial extends ChatState {
  ChatInitial({@required TripRequest tripRequest})
      : super(tripRequest: tripRequest, chatList: []);
}

class ChatAddedState extends ChatState {
  ChatAddedState(ChatState state) : super.from(state);
}
