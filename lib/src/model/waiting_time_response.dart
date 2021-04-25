// To parse this JSON data, do
//
//     final waitingTimeResponse = waitingTimeResponseFromJson(jsonString);

import 'dart:convert';

class WaitingTimeResponse {
  WaitingTimeResponse({
    this.waitingTime,
    this.waitingStatus,
  });

  int waitingTime;
  int waitingStatus;

  factory WaitingTimeResponse.fromRawJson(String str) =>
      WaitingTimeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WaitingTimeResponse.fromJson(Map<String, dynamic> json) =>
      WaitingTimeResponse(
        waitingTime: json["waitingTime"] == null ? null : json["waitingTime"],
        waitingStatus:
            json["waitingStatus"] == null ? null : json["waitingStatus"],
      );

  Map<String, dynamic> toJson() => {
        "waitingTime": waitingTime == null ? null : waitingTime,
        "waitingStatus": waitingStatus == null ? null : waitingStatus,
      };
}
