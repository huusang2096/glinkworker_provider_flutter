import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/login_request.dart';
import 'package:glinkwok_provider/src/model/login_response.dart';
import 'package:glinkwok_provider/src/services/trip_service.dart';
import 'package:simplest/simplest.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final _notificationService = locator<NotificationService>();

  submitLogin({String email, PhoneNumber phoneNumber, String password}) async {
    LoginRequest request = LoginRequest();

    if (state.isCheckLoginByPhone) {
      request.mobile = phoneNumber.parseNumber();
      request.countryCode = phoneNumber.dialCode;
    } else {
      request.email = email;
    }

    request.password = password;
    request.deviceId = await DeviceHelper.deviceId;
    request.deviceToken = _notificationService.fcmToken;
    request.deviceType = DeviceHelper.deviceType;

    try {
      emit(state.copyWith(isLoading: true));
      LoginResponse loginResponse = await dataRepository.login(request);
      await appPref.setToken(loginResponse.accessToken);
      dataRepository.loadAuthHeader();
      appPref.loginRequest = state.isCheckSaveAccount ? request : null;
      final profileResponse = await dataRepository.getProfile();
      appPref.user = profileResponse;
      emit(LoginSuccessState(state));
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isLoading: false));
  }

  toggleRememberMe() {
    bool _isCheckSaveAccount = !state.isCheckSaveAccount;
    emit(ToggleRemberMeState(state, _isCheckSaveAccount));
  }

  toggleLoginByPhone() {
    bool _isCheckLoginByPhone = !state.isCheckLoginByPhone;
    emit(ToggleLoginByPhoneState(state, _isCheckLoginByPhone));
  }

  gotToForgot() {
    navigator.pushReplacementNamed(AppRoute.forgotScreen);
  }

  checkSavedCredential() {
    final oldRequest = appPref.loginRequest;
    if (oldRequest == null) {
      return;
    }
    final _isUsePhone = oldRequest.email == null;
    emit(ShowSavedCredential(
      loginRequest: oldRequest,
      isCheckLoginByPhone: _isUsePhone,
      isCheckSaveAccount: true,
      state: state,
    ));
  }
}
