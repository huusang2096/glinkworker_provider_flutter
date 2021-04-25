import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/wallet_transaction_response_model.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  getWalletTransaction() async {
    try {
      emit(state.copyWith(isLoading: true));
      final WalletTransactionResponse walletTransactionResponse =
          await dataRepository.getWalletTransaction();
      emit(GetWalletState(walletTransactionResponse, state));
    } catch (e) {
      print("Error" + e.toString());
      handleAppError(e);
    }
    emit(state.copyWith(isLoading: false));
  }
}
