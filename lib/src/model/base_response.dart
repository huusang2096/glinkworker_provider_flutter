// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';

class BaseResponse {
  BaseResponse({
    this.status,
    this.errorCode,
    this.message,
  });

  bool status;
  String errorCode;
  String message;

  factory BaseResponse.fromRawJson(String str) =>
      BaseResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        status: json["status"] == null ? null : json["status"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "error_code": errorCode == null ? null : errorCode,
        "message": message == null ? null : message,
      };
}
