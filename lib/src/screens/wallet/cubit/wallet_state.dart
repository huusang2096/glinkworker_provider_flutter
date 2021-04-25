part of 'wallet_cubit.dart';

class WalletState {
  WalletTransactionResponse wallet;
  bool isLoading;

  WalletState(this.wallet, this.isLoading);

  WalletState copyWith({
    WalletTransactionResponse wallet,
    bool isLoading,
  }) {
    return WalletState(wallet ?? this.wallet, isLoading ?? this.isLoading);
  }

  WalletState.from(WalletState state) {
    wallet = state.wallet;
    isLoading = state.isLoading;
  }
}

class WalletInitial extends WalletState {
  WalletInitial() : super(null, false);
}

class GetWalletState extends WalletState {
  GetWalletState(WalletTransactionResponse wallet, WalletState state)
      : super.from(state.copyWith(wallet: wallet));
}
