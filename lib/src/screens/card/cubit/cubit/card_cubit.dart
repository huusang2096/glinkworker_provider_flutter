import 'package:bloc/bloc.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/card_response.dart';
import 'package:meta/meta.dart';

part 'card_state.dart';

class CardCubit extends BaseCubit<CardState> {
  CardCubit() : super(CardInitial());

  getCardPayment() async {
    try {
      final response = await dataRepository.getProviderCard();
      emit(GetCardPayment(response));
    } catch (e) {
      handleAppError(e);
    }
  }

  addCard(String stripeToken) async {
    try {
      final response = await dataRepository.addCard(stripeToken);
      emit(AddCardSuccesState(response.message, state));
    } catch (e) {
      handleAppError(e);
    }
  }
}
