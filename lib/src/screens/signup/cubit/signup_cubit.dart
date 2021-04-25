import 'dart:io';

import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/register_request.dart';
import 'package:glinkwok_provider/src/model/register_response.dart';
import 'package:simplest/simplest.dart';

part 'signup_state.dart';

class SignupCubit extends BaseCubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final _phoneAuthService = locator<PhoneAuthService>();

  submitRegister() async {
    try {
      final _registerRequest = state.registerRequest;
      _registerRequest.deviceType = Platform.operatingSystem.toString();
      _registerRequest.deviceToken = locator<NotificationService>().fcmToken;
      _registerRequest.deviceId = await DeviceHelper.deviceId;

      var _phoneNumber = state.phoneNumber;
      logger.d('_phoneNumber ${_phoneNumber.phoneNumber}');
      try {
        _phoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
            _phoneNumber.phoneNumber);
      } catch (err) {
        showErrorMessage('invalid_phone_number'.tr);
        return;
      }

      /*-verify otp-*/
      final response =
          await _phoneAuthService.verifyPhoneNumber(_phoneNumber.phoneNumber);
      logger.d("verifyToken ${response.verifyToken}");
      _registerRequest.verifyToken = response.verifyToken;
      /*----*/
      emit(state.copyWith(inAsyncCall: true));
      final registerResponse = await dataRepository.register(_registerRequest);
      snackbarService.showSnackbar(message: 'register_success'.tr);
      await Future.delayed(Duration(seconds: 2));
      emit(SignupSuccessState(registerResponse, state));
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(inAsyncCall: false));
  }

  touchShowPassword() {
    final isShowPassObsecute = !state.isPasswordObsecure;
    emit(state.copyWith(isPasswordObsecure: isShowPassObsecute));
  }

  touchShowPasswordAgain() {
    final isConfirmObsecure = !state.isConfirmObsecure;
    emit(state.copyWith(isConfirmObsecure: isConfirmObsecure));
  }

  touchShowCheckboxSaveAccount() {
    final isCheckSaveAccount = !state.isCheckSaveAccount;
    emit(state.copyWith(isCheckSaveAccount: isCheckSaveAccount));
  }

  touchChooseGender(String val) {}

  updateEmail(String email) {
    final _currentRequest = state.registerRequest;
    _currentRequest.email = email;
    emit(state.copyWith(registerRequest: _currentRequest));
  }

  updateFirstName(String firstName) {
    final _currentRequest = state.registerRequest;
    _currentRequest.firstName = firstName;
    emit(state.copyWith(registerRequest: _currentRequest));
  }

  updateLastName(String lastName) {
    final _currentRequest = state.registerRequest;
    _currentRequest.lastName = lastName;
    emit(state.copyWith(registerRequest: _currentRequest));
  }

  selectGender(String gender) {
    final _currentRequest = state.registerRequest;
    _currentRequest.gender = gender;
    emit(state.copyWith(registerRequest: _currentRequest));
  }

  updatePassword(String password) {
    final _currentRequest = state.registerRequest;
    _currentRequest.password = password;
    emit(state.copyWith(registerRequest: _currentRequest));
  }

  updateConfirmPassword(String confirmPassword) {
    final _currentRequest = state.registerRequest;
    _currentRequest.passwordConfirmation = confirmPassword;
    emit(state.copyWith(registerRequest: _currentRequest));
  }

  updatePhoneNumber(PhoneNumber phoneNumber) async {
    try {
      final parsedPhoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
          phoneNumber.phoneNumber);
      final _registerRequest = state.registerRequest;
      final _dialCodePhone = parsedPhoneNumber.dialCode.replaceAll("+", "");
      final _countryCode = '+$_dialCodePhone';
      _registerRequest.mobile =
          (await PhoneNumber.getParsableNumber(parsedPhoneNumber))
              .replaceAll(" ", "");
      _registerRequest.countryCode = _countryCode;
      emit(state.copyWith(
          phoneNumber: phoneNumber, registerRequest: _registerRequest));
    } catch (err) {
      logger.d(err);
    }
  }
}
