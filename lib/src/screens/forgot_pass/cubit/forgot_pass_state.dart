part of 'forgot_pass_cubit.dart';

class ForgotPassState {
  bool inAsyncCall;
  ForgotPassState({this.inAsyncCall});

  ForgotPassState copyWith({bool inAsyncCall}) {
    return ForgotPassState(inAsyncCall: inAsyncCall ?? this.inAsyncCall);
  }
}

class ForgotPassInitial extends ForgotPassState {
  ForgotPassInitial() : super(inAsyncCall: false);
}

class ForgotPasswordSuccess extends ForgotPassState {
  ForgotPasswordSuccess() : super(inAsyncCall: false);
}
