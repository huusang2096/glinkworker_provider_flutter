part of 'signup_cubit.dart';

class SignupState {
  bool isPasswordObsecure;
  bool isConfirmObsecure;
  bool isCheckSaveAccount;
  bool inAsyncCall;
  PhoneNumber phoneNumber;
  RegisterRequest registerRequest;

  SignupState(
      {this.isPasswordObsecure,
      this.isConfirmObsecure,
      this.isCheckSaveAccount,
      this.registerRequest,
      this.phoneNumber,
      this.inAsyncCall});

  SignupState copyWith(
      {bool isPasswordObsecure,
      bool isConfirmObsecure,
      bool isCheckSaveAccount,
      RegisterRequest registerRequest,
      PhoneNumber phoneNumber,
      bool inAsyncCall}) {
    return SignupState(
        isPasswordObsecure: isPasswordObsecure ?? this.isPasswordObsecure,
        isConfirmObsecure: isConfirmObsecure ?? this.isPasswordObsecure,
        isCheckSaveAccount: isCheckSaveAccount ?? this.isCheckSaveAccount,
        registerRequest: registerRequest ?? this.registerRequest,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        inAsyncCall: inAsyncCall ?? this.inAsyncCall);
  }

  SignupState.from(SignupState state) {
    this.isPasswordObsecure = state.isPasswordObsecure;
    this.isConfirmObsecure = state.isConfirmObsecure;
    this.isCheckSaveAccount = state.isCheckSaveAccount;
    this.registerRequest = state.registerRequest;
    this.phoneNumber = state.phoneNumber;
    this.inAsyncCall = state.inAsyncCall;
  }
}

class SignupInitial extends SignupState {
  SignupInitial()
      : super(
            isPasswordObsecure: true,
            isConfirmObsecure: true,
            isCheckSaveAccount: false,
            inAsyncCall: false,
            registerRequest: RegisterRequest(gender: 'male'));
}

class SignupSuccessState extends SignupState {
  final RegisterResponse registerResponse;
  SignupSuccessState(this.registerResponse, SignupState state)
      : super.from(state);
}

class SignupFailState extends SignupState {
  final String message;
  SignupFailState(this.message, SignupState state) : super.from(state);
}

class SignupUpdateObsecurePassState extends SignupState {
  SignupUpdateObsecurePassState(bool isPasswordObsecure, bool isConfirmObsecure,
      bool isCheckSaveAccount, String gender, SignupState state)
      : super.from(state.copyWith(
          isPasswordObsecure: isPasswordObsecure,
          isConfirmObsecure: isConfirmObsecure,
          isCheckSaveAccount: isCheckSaveAccount,
        ));
}
