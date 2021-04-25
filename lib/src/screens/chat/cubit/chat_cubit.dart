import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/chat.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:meta/meta.dart';
import 'package:simplest/simplest.dart';
import 'package:firebase_database/firebase_database.dart';

part 'chat_state.dart';

class ChatCubit extends BaseCubit<ChatState> {
  ChatCubit({@required TripRequest tripRequest})
      : super(ChatInitial(tripRequest: tripRequest));

  DatabaseReference get _chatRef {
    return FirebaseDatabase.instance
        .reference()
        .child('${state.tripRequest.requestId}');
  }

  loadChat() {
    logger.d('${state.tripRequest.requestId}');
    subscriptions.add(_chatRef.onChildAdded.listen((event) {
      final data = event.snapshot.value;
      final mapData = Map<String, dynamic>.from(data);
      Chat chat = Chat.fromJson(mapData);
      logger.d(chat.toRawJson());
      final list = [...state.chatList]..insert(0, chat);
      emit(ChatAddedState(state.copyWith(chatList: list)));
    }));
  }

  send(String message) async {
    if (message.trim().isEmpty) {
      return;
    }
    try {
      final chat = Chat(
          sender: 'provider',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          type: 'text',
          text: message,
          read: 0,
          driverId: '${state.tripRequest.providerId}',
          userId: '${state.tripRequest.detail.user.id}');
      _chatRef.push().update(chat.toJson());
      await dataRepository.postChatItem(
          sender: 'provider',
          userId: '${state.tripRequest.providerId}',
          message: message);
    } catch (e) {
      handleAppError(e);
    }
  }
}
