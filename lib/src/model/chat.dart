// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

class Chat {
  Chat({
    this.sender,
    this.timestamp,
    this.type,
    this.text,
    this.url,
    this.read,
    this.userId,
    this.driverId,
  });

  String sender;
  int timestamp;
  String type;
  String text;
  String url;
  int read;
  String userId;
  String driverId;

  factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        sender: json["sender"] == null ? null : json["sender"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        type: json["type"] == null ? null : json["type"],
        text: json["text"] == null ? null : json["text"],
        url: json["url"] == null ? null : json["url"],
        read: json["read"] == null ? null : json["read"],
        userId: json["userId"] == null ? null : json["userId"],
        driverId: json["driverId"] == null ? null : json["driverId"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender == null ? null : sender,
        "timestamp": timestamp == null ? null : timestamp,
        "type": type == null ? null : type,
        "text": text == null ? null : text,
        "url": url == null ? null : url,
        "read": read == null ? null : read,
        "userId": userId == null ? null : userId,
        "driverId": driverId == null ? null : driverId,
      };
}
