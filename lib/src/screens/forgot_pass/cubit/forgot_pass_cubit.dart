import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/model/forgot_password_request.dart';

import 'package:simplest/simplest.dart';

part 'forgot_pass_state.dart';

class ForgotPassCubit extends BaseCubit<ForgotPassState> {
  ForgotPassCubit() : super(ForgotPassInitial());

  final _phoneAuthService = locator<PhoneAuthService>();

  submit(
      {PhoneNumber phoneNumber,
      String password,
      String confirmPassword,
      String region}) async {
    if (phoneNumber.parseNumber().isEmpty || password.isEmpty) {
      showErrorMessage('please_enter_all_fields');
      return;
    }

    if (password != confirmPassword) {
      showErrorMessage('password_is_not_match');
      return;
    }

    if (password.length < 6) {
      showErrorMessage('password_length_incorrect');
      return;
    }

    try {
      logger.d(phoneNumber.e164);
      emit(ForgotPassState(inAsyncCall: true));
      final response =
          await _phoneAuthService.verifyPhoneNumber(phoneNumber.e164);
      final _forgotRequest = ForgotPasswordRequest(
        verifyToken: response.verifyToken,
        password: password,
        passwordConfirmation: confirmPassword,
        mobile: phoneNumber.parsedNumber,
        countryCode: '+${phoneNumber.callingCode}',
      );
      await dataRepository.resetPassword(_forgotRequest);
      snackbarService.showSnackbar(message: 'reset_password_success'.tr);
      await Future.delayed(Duration(seconds: 2));
      navigator.pushReplacementNamed(AppRoute.loginScreen);
      logger.d('verifyToken ${response.verifyToken}');
    } catch (error) {
      handleAppError(error);
    }
    emit(ForgotPassState(inAsyncCall: false));
  }

  gotoLogin() {
    navigator.pushReplacementNamed(AppRoute.loginScreen);
  }
}
