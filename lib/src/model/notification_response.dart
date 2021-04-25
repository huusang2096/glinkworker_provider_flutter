// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

class NotificationResponse {
  NotificationResponse({
    this.id,
    this.notifyType,
    this.image,
    this.description,
    this.expiryDate,
    this.status,
  });

  int id;
  String notifyType;
  String image;
  String description;
  String expiryDate;
  String status;

  factory NotificationResponse.fromRawJson(String str) =>
      NotificationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        id: json["id"] == null ? null : json["id"],
        notifyType: json["notify_type"] == null ? null : json["notify_type"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"] == null ? null : json["description"],
        expiryDate: json["expiry_date"] == null ? null : json["expiry_date"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "notify_type": notifyType == null ? null : notifyType,
        "image": image == null ? null : image,
        "description": description == null ? null : description,
        "expiry_date": expiryDate == null ? null : expiryDate,
        "status": status == null ? null : status,
      };
}
