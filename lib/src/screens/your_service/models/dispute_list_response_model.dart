// To parse this JSON data, do
//
//     final disputeListResponse = disputeListResponseFromJson(jsonString);

import 'dart:convert';

class DisputeListResponse {
  DisputeListResponse({
    this.disputeName,
  });

  String disputeName;

  factory DisputeListResponse.fromRawJson(String str) =>
      DisputeListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DisputeListResponse.fromJson(Map<String, dynamic> json) =>
      DisputeListResponse(
        disputeName: json["dispute_name"] == null ? null : json["dispute_name"],
      );

  Map<String, dynamic> toJson() => {
        "dispute_name": disputeName == null ? null : disputeName,
      };
}
