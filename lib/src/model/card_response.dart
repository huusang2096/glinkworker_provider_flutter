// To parse this JSON data, do
//
//     final cardResponse = cardResponseFromJson(jsonString);

import 'dart:convert';

class CardResponse {
  CardResponse({
    this.id,
    this.userId,
    this.lastFour,
    this.cardId,
    this.brand,
    this.isDefault,
  });

  int id;
  int userId;
  String lastFour;
  String cardId;
  String brand;
  int isDefault;

  factory CardResponse.fromRawJson(String str) =>
      CardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        lastFour: json["last_four"] == null ? null : json["last_four"],
        cardId: json["card_id"] == null ? null : json["card_id"],
        brand: json["brand"] == null ? null : json["brand"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "last_four": lastFour == null ? null : lastFour,
        "card_id": cardId == null ? null : cardId,
        "brand": brand == null ? null : brand,
        "is_default": isDefault == null ? null : isDefault,
      };
}
