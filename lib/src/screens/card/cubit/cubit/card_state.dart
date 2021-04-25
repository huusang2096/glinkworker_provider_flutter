part of 'card_cubit.dart';

class CardState {
  List<CardResponse> card;
  String message;
  CardState({this.card, this.message});
  CardState.from(CardState state) {
    this.card = state.card;
    this.message = state.message;
  }
  CardState copyWith({List<CardResponse> card, String message}) {
    return CardState(card: card ?? this.card, message: message ?? this.message);
  }
}

class CardInitial extends CardState {
  CardInitial() : super();
}

class GetCardPayment extends CardState {
  GetCardPayment(List<CardResponse> card) : super(card: card);
}

class AddCardSuccesState extends CardState {
  AddCardSuccesState(String message, CardState state)
      : super.from(state.copyWith(message: message));
}
