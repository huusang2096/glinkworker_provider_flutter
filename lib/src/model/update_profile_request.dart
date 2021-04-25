// To parse this JSON data, do
//
//     final UpdateProfileRequest = UpdateProfileRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.countryCode,
    this.mobile,
    this.lastName,
    this.firstName,
    this.email,
    this.avatar,
  });

  String countryCode;
  String mobile;
  String lastName;
  String firstName;
  String email;
  File avatar;

  factory UpdateProfileRequest.fromRawJson(String str) =>
      UpdateProfileRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        countryCode: json["country_code"] == null ? null : json["country_code"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        email: json["email"] == null ? null : json["email"],
        avatar: json["avatar"] == null ? null : json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode == null ? null : countryCode,
        "mobile": mobile == null ? null : mobile,
        "last_name": lastName == null ? null : lastName,
        "first_name": firstName == null ? null : firstName,
        "email": email == null ? null : email,
        "avatar": avatar == null ? null : avatar,
      };
}

extension UpdateProfileRequestExt on UpdateProfileRequest {
  UpdateProfileRequest copy() {
    return UpdateProfileRequest.fromJson(this.toJson());
  }
}
