// To parse this JSON data, do
//
//     final updateTripRequest = updateTripRequestFromJson(jsonString);

import 'dart:convert';

class UpdateTripRequest {
  UpdateTripRequest({
    this.status,
    this.method,
    this.tollPrice,
    this.latitude,
    this.longitude,
    this.requestId,
    this.tips,
    this.paymentType,
    this.paymentMode,
  });

  String status;
  String method;
  double tollPrice;
  double latitude;
  double longitude;
  int requestId;
  double tips;
  String paymentType;
  String paymentMode;

  factory UpdateTripRequest.fromRawJson(String str) =>
      UpdateTripRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateTripRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTripRequest(
        status: json["status"] == null ? null : json["status"],
        method: json["_method"] == null ? null : json["_method"],
        tollPrice: json["toll_price"] == null ? null : json["toll_price"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        tips: json["tips"] == null ? null : json["tips"],
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "_method": method == null ? null : method,
        "toll_price": tollPrice == null ? null : tollPrice,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "request_id": requestId == null ? null : requestId,
        "tips": tips == null ? null : tips,
        "payment_type": paymentType == null ? null : paymentType,
        "payment_mode": paymentMode == null ? null : paymentMode,
      };
}
