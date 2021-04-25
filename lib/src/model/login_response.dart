// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
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
  String avatar;
  String rating;
  String status;
  int agent;
  double latitude;
  double longitude;
  dynamic stripeAccId;
  String stripeCustId;
  String paypalEmail;
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
  Services services;
  List<Service> service;
  Device device;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        stripeAccId: json["stripe_acc_id"],
        stripeCustId:
            json["stripe_cust_id"] == null ? null : json["stripe_cust_id"],
        paypalEmail: json["paypal_email"],
        loginBy: json["login_by"] == null ? null : json["login_by"],
        socialUniqueId: json["social_unique_id"],
        otp: json["otp"] == null ? null : json["otp"],
        walletBalance:
            json["wallet_balance"] == null ? null : json["wallet_balance"].toDouble(),
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
        services: json["services"] == null
            ? null
            : Services.fromJson(json["services"]),
        service: json["service"] == null
            ? null
            : List<Service>.from(
                json["service"].map((x) => Service.fromJson(x))),
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
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "stripe_acc_id": stripeAccId,
        "stripe_cust_id": stripeCustId == null ? null : stripeCustId,
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
        "services": services == null ? null : services.toJson(),
        "service": service == null
            ? null
            : List<dynamic>.from(service.map((x) => x.toJson())),
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
  String jwtToken;

  factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        udid: json["udid"] == null ? null : json["udid"],
        token: json["token"] == null ? null : json["token"],
        snsArn: json["sns_arn"],
        type: json["type"] == null ? null : json["type"],
        jwtToken: json["jwt_token"] == null ? null : json["jwt_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "udid": udid == null ? null : udid,
        "token": token == null ? null : token,
        "sns_arn": snsArn,
        "type": type == null ? null : type,
        "jwt_token": jwtToken == null ? null : jwtToken,
      };
}

class Service {
  Service({
    this.id,
    this.providerId,
    this.serviceTypeId,
    this.status,
    this.serviceNumber,
    this.serviceModel,
    this.serviceType,
  });

  int id;
  int providerId;
  int serviceTypeId;
  String status;
  String serviceNumber;
  String serviceModel;
  ServiceType serviceType;

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        serviceTypeId:
            json["service_type_id"] == null ? null : json["service_type_id"],
        status: json["status"] == null ? null : json["status"],
        serviceNumber:
            json["service_number"] == null ? null : json["service_number"],
        serviceModel:
            json["service_model"] == null ? null : json["service_model"],
        serviceType: json["service_type"] == null
            ? null
            : ServiceType.fromJson(json["service_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "service_type_id": serviceTypeId == null ? null : serviceTypeId,
        "status": status == null ? null : status,
        "service_number": serviceNumber == null ? null : serviceNumber,
        "service_model": serviceModel == null ? null : serviceModel,
        "service_type": serviceType == null ? null : serviceType.toJson(),
      };
}

class ServiceType {
  ServiceType({
    this.id,
    this.parentId,
    this.agentId,
    this.name,
    this.providerName,
    this.image,
    this.marker,
    this.fixed,
    this.price,
    this.typePrice,
    this.calculator,
    this.description,
    this.status,
  });

  int id;
  int parentId;
  int agentId;
  String name;
  String providerName;
  String image;
  String marker;
  int fixed;
  int price;
  int typePrice;
  String calculator;
  dynamic description;
  int status;

  factory ServiceType.fromRawJson(String str) =>
      ServiceType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["id"] == null ? null : json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        agentId: json["agent_id"] == null ? null : json["agent_id"],
        name: json["name"] == null ? null : json["name"],
        providerName:
            json["provider_name"] == null ? null : json["provider_name"],
        image: json["image"] == null ? null : json["image"],
        marker: json["marker"] == null ? null : json["marker"],
        fixed: json["fixed"] == null ? null : json["fixed"],
        price: json["price"] == null ? null : json["price"],
        typePrice: json["type_price"] == null ? null : json["type_price"],
        calculator: json["calculator"] == null ? null : json["calculator"],
        description: json["description"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "parent_id": parentId == null ? null : parentId,
        "agent_id": agentId == null ? null : agentId,
        "name": name == null ? null : name,
        "provider_name": providerName == null ? null : providerName,
        "image": image == null ? null : image,
        "marker": marker == null ? null : marker,
        "fixed": fixed == null ? null : fixed,
        "price": price == null ? null : price,
        "type_price": typePrice == null ? null : typePrice,
        "calculator": calculator == null ? null : calculator,
        "description": description,
        "status": status == null ? null : status,
      };
}

class Services {
  Services({
    this.name,
    this.serviceNumber,
    this.serviceModel,
  });

  String name;
  String serviceNumber;
  String serviceModel;

  factory Services.fromRawJson(String str) =>
      Services.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        name: json["name"] == null ? null : json["name"],
        serviceNumber:
            json["service_number"] == null ? null : json["service_number"],
        serviceModel:
            json["service_model"] == null ? null : json["service_model"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "service_number": serviceNumber == null ? null : serviceNumber,
        "service_model": serviceModel == null ? null : serviceModel,
      };
}
