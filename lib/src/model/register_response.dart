// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.countryCode,
    this.mobile,
    this.avatar,
    this.rating,
    this.status,
    this.agent,
    this.latitude,
    this.longitude,
    this.stripeAccId,
    this.stripeCustId,
    this.paypalEmail,
    this.loginBy,
    this.socialUniqueId,
    this.otp,
    this.walletBalance,
    this.referralUniqueId,
    this.qrcodeUrl,
    this.trialProEndsAt,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.currency,
    this.sos,
    this.measurement,
    this.services,
    this.service,
    this.device,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String countryCode;
  String mobile;
  dynamic avatar;
  String rating;
  String status;
  int agent;
  dynamic latitude;
  dynamic longitude;
  dynamic stripeAccId;
  dynamic stripeCustId;
  dynamic paypalEmail;
  String loginBy;
  dynamic socialUniqueId;
  int otp;
  double walletBalance;
  String referralUniqueId;
  String qrcodeUrl;
  dynamic trialProEndsAt;
  DateTime createdAt;
  DateTime updatedAt;
  String accessToken;
  String currency;
  String sos;
  String measurement;
  dynamic services;
  List<dynamic> service;
  Device device;

  factory RegisterResponse.fromRawJson(String str) =>
      RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        avatar: json["avatar"],
        rating: json["rating"] == null ? null : json["rating"],
        status: json["status"] == null ? null : json["status"],
        agent: json["agent"] == null ? null : json["agent"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        stripeAccId: json["stripe_acc_id"],
        stripeCustId: json["stripe_cust_id"],
        paypalEmail: json["paypal_email"],
        loginBy: json["login_by"] == null ? null : json["login_by"],
        socialUniqueId: json["social_unique_id"],
        otp: json["otp"] == null ? null : json["otp"],
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toDouble(),
        referralUniqueId: json["referral_unique_id"] == null
            ? null
            : json["referral_unique_id"],
        qrcodeUrl: json["qrcode_url"] == null ? null : json["qrcode_url"],
        trialProEndsAt: json["trial_pro_ends_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        accessToken: json["access_token"] == null ? null : json["access_token"],
        currency: json["currency"] == null ? null : json["currency"],
        sos: json["sos"] == null ? null : json["sos"],
        measurement: json["measurement"] == null ? null : json["measurement"],
        services: json["services"],
        service: json["service"] == null
            ? null
            : List<dynamic>.from(json["service"].map((x) => x)),
        device: json["device"] == null ? null : Device.fromJson(json["device"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "country_code": countryCode == null ? null : countryCode,
        "mobile": mobile == null ? null : mobile,
        "avatar": avatar,
        "rating": rating == null ? null : rating,
        "status": status == null ? null : status,
        "agent": agent == null ? null : agent,
        "latitude": latitude,
        "longitude": longitude,
        "stripe_acc_id": stripeAccId,
        "stripe_cust_id": stripeCustId,
        "paypal_email": paypalEmail,
        "login_by": loginBy == null ? null : loginBy,
        "social_unique_id": socialUniqueId,
        "otp": otp == null ? null : otp,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "referral_unique_id":
            referralUniqueId == null ? null : referralUniqueId,
        "qrcode_url": qrcodeUrl == null ? null : qrcodeUrl,
        "trial_pro_ends_at": trialProEndsAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "access_token": accessToken == null ? null : accessToken,
        "currency": currency == null ? null : currency,
        "sos": sos == null ? null : sos,
        "measurement": measurement == null ? null : measurement,
        "services": services,
        "service":
            service == null ? null : List<dynamic>.from(service.map((x) => x)),
        "device": device == null ? null : device.toJson(),
      };
}

class Device {
  Device({
    this.id,
    this.providerId,
    this.udid,
    this.token,
    this.snsArn,
    this.type,
    this.jwtToken,
  });

  int id;
  int providerId;
  String udid;
  String token;
  dynamic snsArn;
  String type;
  dynamic jwtToken;

  factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        udid: json["udid"] == null ? null : json["udid"],
        token: json["token"] == null ? null : json["token"],
        snsArn: json["sns_arn"],
        type: json["type"] == null ? null : json["type"],
        jwtToken: json["jwt_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "udid": udid == null ? null : udid,
        "token": token == null ? null : token,
        "sns_arn": snsArn,
        "type": type == null ? null : type,
        "jwt_token": jwtToken,
      };
}
