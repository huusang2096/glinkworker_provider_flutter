// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

class ProfileResponse {
  ProfileResponse({
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
    this.service,
    this.currency,
    this.sos,
    this.measurement,
    this.profile,
    this.cash,
    this.card,
    this.debitMachine,
    this.voucher,
    this.stripeSecretKey,
    this.stripePublishableKey,
    this.stripeCurrency,
    this.payumoney,
    this.paypal,
    this.paypalAdaptive,
    this.braintree,
    this.paytm,
    this.payumoneyEnvironment,
    this.payumoneyKey,
    this.payumoneySalt,
    this.payumoneyAuth,
    this.paypalEnvironment,
    this.paypalCurrency,
    this.paypalClientId,
    this.paypalClientSecret,
    this.braintreeEnvironment,
    this.braintreeMerchantId,
    this.braintreePublicKey,
    this.braintreePrivateKey,
    this.referralCount,
    this.referralAmount,
    this.referralText,
    this.referralTotalCount,
    this.referralTotalAmount,
    this.referralTotalText,
    this.rideOtp,
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
  dynamic stripeCustId;
  dynamic paypalEmail;
  String loginBy;
  dynamic socialUniqueId;
  int otp;
  double walletBalance;
  dynamic referralUniqueId;
  dynamic qrcodeUrl;
  dynamic trialProEndsAt;
  DateTime createdAt;
  DateTime updatedAt;
  Service service;
  String currency;
  String sos;
  String measurement;
  dynamic profile;
  int cash;
  int card;
  int debitMachine;
  int voucher;
  String stripeSecretKey;
  String stripePublishableKey;
  String stripeCurrency;
  int payumoney;
  int paypal;
  int paypalAdaptive;
  int braintree;
  int paytm;
  String payumoneyEnvironment;
  String payumoneyKey;
  String payumoneySalt;
  String payumoneyAuth;
  String paypalEnvironment;
  String paypalCurrency;
  String paypalClientId;
  String paypalClientSecret;
  String braintreeEnvironment;
  String braintreeMerchantId;
  String braintreePublicKey;
  String braintreePrivateKey;
  String referralCount;
  String referralAmount;
  String referralText;
  String referralTotalCount;
  int referralTotalAmount;
  String referralTotalText;
  int rideOtp;

  factory ProfileResponse.fromRawJson(String str) =>
      ProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        rating: json["rating"] == null ? null : json["rating"],
        status: json["status"] == null ? null : json["status"],
        agent: json["agent"] == null ? null : json["agent"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        stripeAccId: json["stripe_acc_id"],
        stripeCustId: json["stripe_cust_id"],
        paypalEmail: json["paypal_email"],
        loginBy: json["login_by"] == null ? null : json["login_by"],
        socialUniqueId: json["social_unique_id"],
        otp: json["otp"] == null ? null : json["otp"],
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toDouble(),
        referralUniqueId: json["referral_unique_id"],
        qrcodeUrl: json["qrcode_url"],
        trialProEndsAt: json["trial_pro_ends_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        currency: json["currency"] == null ? null : json["currency"],
        sos: json["sos"] == null ? null : json["sos"],
        measurement: json["measurement"] == null ? null : json["measurement"],
        profile: json["profile"],
        cash: json["cash"] == null ? null : json["cash"],
        card: json["card"] == null ? null : json["card"],
        debitMachine:
            json["debit_machine"] == null ? null : json["debit_machine"],
        voucher: json["voucher"] == null ? null : json["voucher"],
        stripeSecretKey: json["stripe_secret_key"] == null
            ? null
            : json["stripe_secret_key"],
        stripePublishableKey: json["stripe_publishable_key"] == null
            ? null
            : json["stripe_publishable_key"],
        stripeCurrency:
            json["stripe_currency"] == null ? null : json["stripe_currency"],
        payumoney: json["payumoney"] == null ? null : json["payumoney"],
        paypal: json["paypal"] == null ? null : json["paypal"],
        paypalAdaptive:
            json["paypal_adaptive"] == null ? null : json["paypal_adaptive"],
        braintree: json["braintree"] == null ? null : json["braintree"],
        paytm: json["paytm"] == null ? null : json["paytm"],
        payumoneyEnvironment: json["payumoney_environment"] == null
            ? null
            : json["payumoney_environment"],
        payumoneyKey:
            json["payumoney_key"] == null ? null : json["payumoney_key"],
        payumoneySalt:
            json["payumoney_salt"] == null ? null : json["payumoney_salt"],
        payumoneyAuth:
            json["payumoney_auth"] == null ? null : json["payumoney_auth"],
        paypalEnvironment: json["paypal_environment"] == null
            ? null
            : json["paypal_environment"],
        paypalCurrency:
            json["paypal_currency"] == null ? null : json["paypal_currency"],
        paypalClientId:
            json["paypal_client_id"] == null ? null : json["paypal_client_id"],
        paypalClientSecret: json["paypal_client_secret"] == null
            ? null
            : json["paypal_client_secret"],
        braintreeEnvironment: json["braintree_environment"] == null
            ? null
            : json["braintree_environment"],
        braintreeMerchantId: json["braintree_merchant_id"] == null
            ? null
            : json["braintree_merchant_id"],
        braintreePublicKey: json["braintree_public_key"] == null
            ? null
            : json["braintree_public_key"],
        braintreePrivateKey: json["braintree_private_key"] == null
            ? null
            : json["braintree_private_key"],
        referralCount:
            json["referral_count"] == null ? null : json["referral_count"],
        referralAmount:
            json["referral_amount"] == null ? null : json["referral_amount"],
        referralText:
            json["referral_text"] == null ? null : json["referral_text"],
        referralTotalCount: json["referral_total_count"] == null
            ? null
            : json["referral_total_count"],
        referralTotalAmount: json["referral_total_amount"] == null
            ? null
            : json["referral_total_amount"],
        referralTotalText: json["referral_total_text"] == null
            ? null
            : json["referral_total_text"],
        rideOtp: json["ride_otp"] == null ? null : json["ride_otp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "country_code": countryCode == null ? null : countryCode,
        "mobile": mobile == null ? null : mobile,
        "avatar": avatar == null ? null : avatar,
        "rating": rating == null ? null : rating,
        "status": status == null ? null : status,
        "agent": agent == null ? null : agent,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "stripe_acc_id": stripeAccId,
        "stripe_cust_id": stripeCustId,
        "paypal_email": paypalEmail,
        "login_by": loginBy == null ? null : loginBy,
        "social_unique_id": socialUniqueId,
        "otp": otp == null ? null : otp,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "referral_unique_id": referralUniqueId,
        "qrcode_url": qrcodeUrl,
        "trial_pro_ends_at": trialProEndsAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "service": service == null ? null : service.toJson(),
        "currency": currency == null ? null : currency,
        "sos": sos == null ? null : sos,
        "measurement": measurement == null ? null : measurement,
        "profile": profile,
        "cash": cash == null ? null : cash,
        "card": card == null ? null : card,
        "debit_machine": debitMachine == null ? null : debitMachine,
        "voucher": voucher == null ? null : voucher,
        "stripe_secret_key": stripeSecretKey == null ? null : stripeSecretKey,
        "stripe_publishable_key":
            stripePublishableKey == null ? null : stripePublishableKey,
        "stripe_currency": stripeCurrency == null ? null : stripeCurrency,
        "payumoney": payumoney == null ? null : payumoney,
        "paypal": paypal == null ? null : paypal,
        "paypal_adaptive": paypalAdaptive == null ? null : paypalAdaptive,
        "braintree": braintree == null ? null : braintree,
        "paytm": paytm == null ? null : paytm,
        "payumoney_environment":
            payumoneyEnvironment == null ? null : payumoneyEnvironment,
        "payumoney_key": payumoneyKey == null ? null : payumoneyKey,
        "payumoney_salt": payumoneySalt == null ? null : payumoneySalt,
        "payumoney_auth": payumoneyAuth == null ? null : payumoneyAuth,
        "paypal_environment":
            paypalEnvironment == null ? null : paypalEnvironment,
        "paypal_currency": paypalCurrency == null ? null : paypalCurrency,
        "paypal_client_id": paypalClientId == null ? null : paypalClientId,
        "paypal_client_secret":
            paypalClientSecret == null ? null : paypalClientSecret,
        "braintree_environment":
            braintreeEnvironment == null ? null : braintreeEnvironment,
        "braintree_merchant_id":
            braintreeMerchantId == null ? null : braintreeMerchantId,
        "braintree_public_key":
            braintreePublicKey == null ? null : braintreePublicKey,
        "braintree_private_key":
            braintreePrivateKey == null ? null : braintreePrivateKey,
        "referral_count": referralCount == null ? null : referralCount,
        "referral_amount": referralAmount == null ? null : referralAmount,
        "referral_text": referralText == null ? null : referralText,
        "referral_total_count":
            referralTotalCount == null ? null : referralTotalCount,
        "referral_total_amount":
            referralTotalAmount == null ? null : referralTotalAmount,
        "referral_total_text":
            referralTotalText == null ? null : referralTotalText,
        "ride_otp": rideOtp == null ? null : rideOtp,
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
