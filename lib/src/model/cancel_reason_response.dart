// To parse this JSON data, do
//
//     final cancelReasonResponse = cancelReasonResponseFromJson(jsonString);

import 'dart:convert';

class CancelReasonResponse {
  CancelReasonResponse({
    this.id,
    this.type,
    this.reason,
    this.status,
  });

  int id;
  String type;
  String reason;
  int status;

  factory CancelReasonResponse.fromRawJson(String str) =>
      CancelReasonResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CancelReasonResponse.fromJson(Map<String, dynamic> json) =>
      CancelReasonResponse(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        reason: json["reason"] == null ? null : json["reason"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "reason": reason == null ? null : reason,
        "status": status == null ? null : status,
      };
}
