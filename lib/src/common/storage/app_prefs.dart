import 'package:glinkwok_provider/src/model/login_request.dart';
import 'package:glinkwok_provider/src/model/profile_response.dart';
import 'package:simplest/simplest.dart';

class AppPref extends BasePrefs {
  SharedPreferences _preferences;

  static Future<AppPref> instance() async {
    final _appPref = AppPref();
    await _appPref.init();
    return _appPref;
  }

  String get token {
    return getValueForKey(PrefKey.token) ?? '';
  }

  setToken(String token) {
    return setValueForKey(PrefKey.token, token);
  }

  ProfileResponse get user {
    final value = getValueForKey(PrefKey.userModel);
    if (value == null) {
      return null;
    }
    return ProfileResponse.fromRawJson(value);
  }

  set user(ProfileResponse value) {
    setValueForKey(PrefKey.userModel, value);
  }

  Future<void> logout() {
    setToken('');
  }

  Future<void> setUserId(String userId) {
    return _preferences.setString(PrefKey.userId, userId);
  }

  String getUserId() {
    return _preferences.getString(PrefKey.userId);
  }

  String get fcmToken {
    return getValueForKey(PrefKey.fcmToken) ?? '';
  }

  set fcmToken(String value) {
    setValueForKey(PrefKey.fcmToken, value);
  }

  LoginRequest get loginRequest {
    final jsonStr = getValueForKey(PrefKey.loginRequest);
    if (jsonStr == null || jsonStr.isEmpty) {
      return null;
    }
    return LoginRequest.fromRawJson(jsonStr);
  }

  set loginRequest(LoginRequest request) {
    if (request == null) {
      prefs.remove(PrefKey.loginRequest);
      return;
    }

    setValueForKey(PrefKey.loginRequest, request);
  }

  String get userName {
    final name = getValueForKey(PrefKey.userName);
    if (name == null || name.isEmpty) {
      return null;
    }
    return name;
  }

  set userName(String name) {
    if (this.userName != null) {
      return;
    }
    if (name == null) {
      prefs.remove(PrefKey.userName);
      return;
    }
    setValueForKey(PrefKey.userName, name);
  }

  String get langCode => getValueForKey(PrefKey.langCode) ?? 'vi';
  set langCode(String code) => setValueForKey(PrefKey.langCode, code);
}

class PrefKey {
  static const String token = 'TOKEN';
  static const String fcmToken = 'FCM_TOKEN';
  static const String userId = 'USER_ID';
  static const String userModel = 'USER_MODEL';
  static const String loginRequest = 'LOGIN_REQUEST';
  static const String userName = 'USER_NAME';
  static const String langCode = 'LANG_CODE';
}
