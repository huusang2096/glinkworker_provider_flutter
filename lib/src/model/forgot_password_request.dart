// To parse this JSON data, do
//
//     final forgotPasswordRequest = ForgotPasswordRequestFromJson(jsonString);

import 'dart:convert';

class ForgotPasswordRequest {
  String verifyToken;
  String countryCode;
  String mobile;
  String password;
  String passwordConfirmation;

  ForgotPasswordRequest(
      {this.countryCode,
      this.password,
      this.passwordConfirmation,
      this.mobile,
      this.verifyToken});

  factory ForgotPasswordRequest.fromRawJson(String str) =>
      ForgotPasswordRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordRequest(
          countryCode:
              json["country_code"] == null ? null : json["country_code"],
          password: json["password"] == null ? null : json["password"],
          passwordConfirmation: json["password_confirmation"] == null
              ? null
              : json["password_confirmation"],
          mobile: json["mobile"] == null ? null : json["mobile"],
          verifyToken:
              json["verify_token"] == null ? null : json["verify_token"]);

  Map<String, dynamic> toJson() => {
        "country_code": countryCode == null ? null : countryCode,
        "password": password == null ? null : password,
        "password_confirmation":
            passwordConfirmation == null ? null : passwordConfirmation,
        "mobile": mobile == null ? null : mobile,
        "verify_token": verifyToken == null ? null : verifyToken
      };
}
