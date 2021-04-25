part of 'login_cubit.dart';

class LoginState {
  bool isCheckSaveAccount;
  bool isCheckLoginByPhone;
  bool isLoading;

  LoginState({
    this.isCheckLoginByPhone,
    this.isCheckSaveAccount,
    this.isLoading,
  });

  LoginState.from(LoginState state) {
    isCheckSaveAccount = state.isCheckSaveAccount;
    isCheckLoginByPhone = state.isCheckLoginByPhone;
    isLoading = state.isLoading;
  }

  LoginState copyWith({
    bool isCheckSaveAccount,
    bool isCheckLoginByPhone,
    bool isLoading,
  }) {
    return LoginState(
      isCheckSaveAccount: isCheckSaveAccount ?? this.isCheckSaveAccount,
      isCheckLoginByPhone: isCheckLoginByPhone ?? this.isCheckLoginByPhone,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginInitial extends LoginState {
  LoginInitial()
      : super(
          isCheckLoginByPhone: false,
          isCheckSaveAccount: false,
          isLoading: false,
        );
}

class LoginSuccessState extends LoginState {
  LoginSuccessState(LoginState state) : super.from(state);
}

class ToggleRemberMeState extends LoginState {
  ToggleRemberMeState(LoginState state, bool isCheckSaveAccount)
      : super.from(state.copyWith(isCheckSaveAccount: isCheckSaveAccount));
}

class ToggleLoginByPhoneState extends LoginState {
  ToggleLoginByPhoneState(LoginState state, bool isCheckLoginByPhone)
      : super.from(state.copyWith(isCheckLoginByPhone: isCheckLoginByPhone));
}

class VerifyPhoneState extends LoginState {
  VerifyPhoneState(LoginState state) : super.from(state);
}

class ShowSavedCredential extends LoginState {
  final LoginRequest loginRequest;
  ShowSavedCredential(
      {this.loginRequest,
      bool isCheckLoginByPhone,
      bool isCheckSaveAccount,
      LoginState state})
      : super.from(state.copyWith(
          isCheckLoginByPhone: isCheckLoginByPhone,
          isCheckSaveAccount: isCheckSaveAccount,
        ));
}
