// To parse this JSON data, do
//
//     final summaryResponse = summaryResponseFromJson(jsonString);

import 'dart:convert';

class SummaryResponse {
  SummaryResponse({
    this.rides,
    this.revenue,
    this.montlyPass,
    this.montlyGains,
    this.cancelRides,
    this.completedRides,
  });

  int rides;
  double revenue;
  double montlyPass;
  double montlyGains;
  int cancelRides;
  int completedRides;

  factory SummaryResponse.fromRawJson(String str) =>
      SummaryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryResponse.fromJson(Map<String, dynamic> json) =>
      SummaryResponse(
        rides: json["rides"] == null ? null : json["rides"],
        revenue: json["revenue"] == null ? null : json["revenue"].toDouble(),
        montlyPass:
            json["montly_pass"] == null ? null : json["montly_pass"].toDouble(),
        montlyGains: json["montly_gains"] == null
            ? null
            : json["montly_gains"].toDouble(),
        cancelRides: json["cancel_rides"] == null ? null : json["cancel_rides"],
        completedRides:
            json["completed_rides"] == null ? null : json["completed_rides"],
      );

  Map<String, dynamic> toJson() => {
        "rides": rides == null ? null : rides,
        "revenue": revenue == null ? null : revenue,
        "montly_pass": montlyPass,
        "montly_gains": montlyGains == null ? null : montlyGains,
        "cancel_rides": cancelRides == null ? null : cancelRides,
        "completed_rides": completedRides == null ? null : completedRides,
      };
}
