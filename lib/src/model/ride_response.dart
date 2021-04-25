// To parse this JSON data, do
//
//     final rideResponse = rideResponseFromJson(jsonString);

import 'dart:convert';

class RideResponse {
  RideResponse({
    this.rides,
    this.ridesCount,
    this.target,
  });

  List<Ride> rides;
  int ridesCount;
  String target;

  factory RideResponse.fromRawJson(String str) =>
      RideResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RideResponse.fromJson(Map<String, dynamic> json) => RideResponse(
        rides: json["rides"] == null
            ? null
            : List<Ride>.from(json["rides"].map((x) => Ride.fromJson(x))),
        ridesCount: json["rides_count"] == null ? null : json["rides_count"],
        target: json["target"] == null ? null : json["target"],
      );

  Map<String, dynamic> toJson() => {
        "rides": rides == null
            ? null
            : List<dynamic>.from(rides.map((x) => x.toJson())),
        "rides_count": ridesCount == null ? null : ridesCount,
        "target": target == null ? null : target,
      };
}

class Ride {
  Ride({
    this.id,
    this.bookingId,
    this.userId,
    this.braintreeNonce,
    this.providerId,
    this.currentProviderId,
    this.serviceTypeId,
    this.beforeImage,
    this.beforeComment,
    this.afterImage,
    this.afterComment,
    this.promocodeId,
    this.status,
    this.cancelledBy,
    this.cancelReason,
    this.paymentMode,
    this.paid,
    this.isTrack,
    this.distance,
    this.travelTime,
    this.unit,
    this.otp,
    this.sAddress,
    this.sLatitude,
    this.sLongitude,
    this.dAddress,
    this.dLatitude,
    this.dLongitude,
    this.trackDistance,
    this.trackLatitude,
    this.trackLongitude,
    this.destinationLog,
    this.isDropLocation,
    this.isInstantRide,
    this.isDispute,
    this.assignedAt,
    this.scheduleAt,
    this.startedAt,
    this.finishedAt,
    this.isScheduled,
    this.userRated,
    this.providerRated,
    this.useWallet,
    this.surge,
    this.routeKey,
    this.nonce,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.payment,
    this.serviceType,
  });

  int id;
  String bookingId;
  int userId;
  dynamic braintreeNonce;
  int providerId;
  int currentProviderId;
  int serviceTypeId;
  dynamic beforeImage;
  dynamic beforeComment;
  dynamic afterImage;
  dynamic afterComment;
  int promocodeId;
  String status;
  String cancelledBy;
  dynamic cancelReason;
  String paymentMode;
  int paid;
  String isTrack;
  int distance;
  String travelTime;
  String unit;
  String otp;
  String sAddress;
  double sLatitude;
  double sLongitude;
  String dAddress;
  double dLatitude;
  double dLongitude;
  int trackDistance;
  int trackLatitude;
  int trackLongitude;
  String destinationLog;
  int isDropLocation;
  int isInstantRide;
  int isDispute;
  DateTime assignedAt;
  dynamic scheduleAt;
  DateTime startedAt;
  DateTime finishedAt;
  String isScheduled;
  int userRated;
  int providerRated;
  int useWallet;
  int surge;
  String routeKey;
  dynamic nonce;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Payment payment;
  ServiceType serviceType;

  factory Ride.fromRawJson(String str) => Ride.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        id: json["id"] == null ? null : json["id"],
        bookingId: json["booking_id"] == null ? null : json["booking_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        braintreeNonce: json["braintree_nonce"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        currentProviderId: json["current_provider_id"] == null
            ? null
            : json["current_provider_id"],
        serviceTypeId:
            json["service_type_id"] == null ? null : json["service_type_id"],
        beforeImage: json["before_image"],
        beforeComment: json["before_comment"],
        afterImage: json["after_image"],
        afterComment: json["after_comment"],
        promocodeId: json["promocode_id"] == null ? null : json["promocode_id"],
        status: json["status"] == null ? null : json["status"],
        cancelledBy: json["cancelled_by"] == null ? null : json["cancelled_by"],
        cancelReason: json["cancel_reason"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        paid: json["paid"] == null ? null : json["paid"],
        isTrack: json["is_track"] == null ? null : json["is_track"],
        distance: json["distance"] == null ? null : json["distance"],
        travelTime: json["travel_time"] == null ? null : json["travel_time"],
        unit: json["unit"] == null ? null : json["unit"],
        otp: json["otp"] == null ? null : json["otp"],
        sAddress: json["s_address"] == null ? null : json["s_address"],
        sLatitude:
            json["s_latitude"] == null ? null : json["s_latitude"].toDouble(),
        sLongitude:
            json["s_longitude"] == null ? null : json["s_longitude"].toDouble(),
        dAddress: json["d_address"] == null ? null : json["d_address"],
        dLatitude:
            json["d_latitude"] == null ? null : json["d_latitude"].toDouble(),
        dLongitude:
            json["d_longitude"] == null ? null : json["d_longitude"].toDouble(),
        trackDistance:
            json["track_distance"] == null ? null : json["track_distance"],
        trackLatitude:
            json["track_latitude"] == null ? null : json["track_latitude"],
        trackLongitude:
            json["track_longitude"] == null ? null : json["track_longitude"],
        destinationLog:
            json["destination_log"] == null ? null : json["destination_log"],
        isDropLocation:
            json["is_drop_location"] == null ? null : json["is_drop_location"],
        isInstantRide:
            json["is_instant_ride"] == null ? null : json["is_instant_ride"],
        isDispute: json["is_dispute"] == null ? null : json["is_dispute"],
        assignedAt: json["assigned_at"] == null
            ? null
            : DateTime.parse(json["assigned_at"]),
        scheduleAt: json["schedule_at"],
        startedAt: json["started_at"] == null
            ? null
            : DateTime.parse(json["started_at"]),
        finishedAt: json["finished_at"] == null
            ? null
            : DateTime.parse(json["finished_at"]),
        isScheduled: json["is_scheduled"] == null ? null : json["is_scheduled"],
        userRated: json["user_rated"] == null ? null : json["user_rated"],
        providerRated:
            json["provider_rated"] == null ? null : json["provider_rated"],
        useWallet: json["use_wallet"] == null ? null : json["use_wallet"],
        surge: json["surge"] == null ? null : json["surge"],
        routeKey: json["route_key"] == null ? null : json["route_key"],
        nonce: json["nonce"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        serviceType: json["service_type"] == null
            ? null
            : ServiceType.fromJson(json["service_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "booking_id": bookingId == null ? null : bookingId,
        "user_id": userId == null ? null : userId,
        "braintree_nonce": braintreeNonce,
        "provider_id": providerId == null ? null : providerId,
        "current_provider_id":
            currentProviderId == null ? null : currentProviderId,
        "service_type_id": serviceTypeId == null ? null : serviceTypeId,
        "before_image": beforeImage,
        "before_comment": beforeComment,
        "after_image": afterImage,
        "after_comment": afterComment,
        "promocode_id": promocodeId == null ? null : promocodeId,
        "status": status == null ? null : status,
        "cancelled_by": cancelledBy == null ? null : cancelledBy,
        "cancel_reason": cancelReason,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "paid": paid == null ? null : paid,
        "is_track": isTrack == null ? null : isTrack,
        "distance": distance == null ? null : distance,
        "travel_time": travelTime == null ? null : travelTime,
        "unit": unit == null ? null : unit,
        "otp": otp == null ? null : otp,
        "s_address": sAddress == null ? null : sAddress,
        "s_latitude": sLatitude == null ? null : sLatitude,
        "s_longitude": sLongitude == null ? null : sLongitude,
        "d_address": dAddress == null ? null : dAddress,
        "d_latitude": dLatitude == null ? null : dLatitude,
        "d_longitude": dLongitude == null ? null : dLongitude,
        "track_distance": trackDistance == null ? null : trackDistance,
        "track_latitude": trackLatitude == null ? null : trackLatitude,
        "track_longitude": trackLongitude == null ? null : trackLongitude,
        "destination_log": destinationLog == null ? null : destinationLog,
        "is_drop_location": isDropLocation == null ? null : isDropLocation,
        "is_instant_ride": isInstantRide == null ? null : isInstantRide,
        "is_dispute": isDispute == null ? null : isDispute,
        "assigned_at": assignedAt == null ? null : assignedAt.toIso8601String(),
        "schedule_at": scheduleAt,
        "started_at": startedAt == null ? null : startedAt.toIso8601String(),
        "finished_at": finishedAt == null ? null : finishedAt.toIso8601String(),
        "is_scheduled": isScheduled == null ? null : isScheduled,
        "user_rated": userRated == null ? null : userRated,
        "provider_rated": providerRated == null ? null : providerRated,
        "use_wallet": useWallet == null ? null : useWallet,
        "surge": surge == null ? null : surge,
        "route_key": routeKey == null ? null : routeKey,
        "nonce": nonce,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "payment": payment == null ? null : payment.toJson(),
        "service_type": serviceType == null ? null : serviceType.toJson(),
      };
}

class Payment {
  Payment({
    this.id,
    this.requestId,
    this.userId,
    this.providerId,
    this.agentId,
    this.promocodeId,
    this.paymentId,
    this.paymentMode,
    this.fixed,
    this.distance,
    this.timePrice,
    this.minute,
    this.hour,
    this.commision,
    this.commisionPer,
    this.agent,
    this.agentPer,
    this.discount,
    this.discountPer,
    this.tax,
    this.taxPer,
    this.wallet,
    this.isPartial,
    this.cash,
    this.card,
    this.online,
    this.surge,
    this.tollCharge,
    this.roundOf,
    this.peakAmount,
    this.peakCommAmount,
    this.totalWaitingTime,
    this.waitingAmount,
    this.waitingCommAmount,
    this.tips,
    this.total,
    this.payable,
    this.providerCommission,
    this.providerPay,
  });

  int id;
  int requestId;
  int userId;
  int providerId;
  dynamic agentId;
  dynamic promocodeId;
  dynamic paymentId;
  String paymentMode;
  int fixed;
  int distance;
  int timePrice;
  int minute;
  int hour;
  int commision;
  int commisionPer;
  int agent;
  int agentPer;
  int discount;
  int discountPer;
  int tax;
  int taxPer;
  int wallet;
  int isPartial;
  int cash;
  int card;
  int online;
  int surge;
  int tollCharge;
  int roundOf;
  int peakAmount;
  int peakCommAmount;
  int totalWaitingTime;
  int waitingAmount;
  int waitingCommAmount;
  int tips;
  int total;
  int payable;
  int providerCommission;
  int providerPay;

  factory Payment.fromRawJson(String str) => Payment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"] == null ? null : json["id"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        agentId: json["agent_id"],
        promocodeId: json["promocode_id"],
        paymentId: json["payment_id"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        fixed: json["fixed"] == null ? null : json["fixed"],
        distance: json["distance"] == null ? null : json["distance"],
        timePrice: json["time_price"] == null ? null : json["time_price"],
        minute: json["minute"] == null ? null : json["minute"],
        hour: json["hour"] == null ? null : json["hour"],
        commision: json["commision"] == null ? null : json["commision"],
        commisionPer:
            json["commision_per"] == null ? null : json["commision_per"],
        agent: json["agent"] == null ? null : json["agent"],
        agentPer: json["agent_per"] == null ? null : json["agent_per"],
        discount: json["discount"] == null ? null : json["discount"],
        discountPer: json["discount_per"] == null ? null : json["discount_per"],
        tax: json["tax"] == null ? null : json["tax"],
        taxPer: json["tax_per"] == null ? null : json["tax_per"],
        wallet: json["wallet"] == null ? null : json["wallet"],
        isPartial: json["is_partial"] == null ? null : json["is_partial"],
        cash: json["cash"] == null ? null : json["cash"],
        card: json["card"] == null ? null : json["card"],
        online: json["online"] == null ? null : json["online"],
        surge: json["surge"] == null ? null : json["surge"],
        tollCharge: json["toll_charge"] == null ? null : json["toll_charge"],
        roundOf: json["round_of"] == null ? null : json["round_of"],
        peakAmount: json["peak_amount"] == null ? null : json["peak_amount"],
        peakCommAmount:
            json["peak_comm_amount"] == null ? null : json["peak_comm_amount"],
        totalWaitingTime: json["total_waiting_time"] == null
            ? null
            : json["total_waiting_time"],
        waitingAmount:
            json["waiting_amount"] == null ? null : json["waiting_amount"],
        waitingCommAmount: json["waiting_comm_amount"] == null
            ? null
            : json["waiting_comm_amount"],
        tips: json["tips"] == null ? null : json["tips"],
        total: json["total"] == null ? null : json["total"],
        payable: json["payable"] == null ? null : json["payable"],
        providerCommission: json["provider_commission"] == null
            ? null
            : json["provider_commission"],
        providerPay: json["provider_pay"] == null ? null : json["provider_pay"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "request_id": requestId == null ? null : requestId,
        "user_id": userId == null ? null : userId,
        "provider_id": providerId == null ? null : providerId,
        "agent_id": agentId,
        "promocode_id": promocodeId,
        "payment_id": paymentId,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "fixed": fixed == null ? null : fixed,
        "distance": distance == null ? null : distance,
        "time_price": timePrice == null ? null : timePrice,
        "minute": minute == null ? null : minute,
        "hour": hour == null ? null : hour,
        "commision": commision == null ? null : commision,
        "commision_per": commisionPer == null ? null : commisionPer,
        "agent": agent == null ? null : agent,
        "agent_per": agentPer == null ? null : agentPer,
        "discount": discount == null ? null : discount,
        "discount_per": discountPer == null ? null : discountPer,
        "tax": tax == null ? null : tax,
        "tax_per": taxPer == null ? null : taxPer,
        "wallet": wallet == null ? null : wallet,
        "is_partial": isPartial == null ? null : isPartial,
        "cash": cash == null ? null : cash,
        "card": card == null ? null : card,
        "online": online == null ? null : online,
        "surge": surge == null ? null : surge,
        "toll_charge": tollCharge == null ? null : tollCharge,
        "round_of": roundOf == null ? null : roundOf,
        "peak_amount": peakAmount == null ? null : peakAmount,
        "peak_comm_amount": peakCommAmount == null ? null : peakCommAmount,
        "total_waiting_time":
            totalWaitingTime == null ? null : totalWaitingTime,
        "waiting_amount": waitingAmount == null ? null : waitingAmount,
        "waiting_comm_amount":
            waitingCommAmount == null ? null : waitingCommAmount,
        "tips": tips == null ? null : tips,
        "total": total == null ? null : total,
        "payable": payable == null ? null : payable,
        "provider_commission":
            providerCommission == null ? null : providerCommission,
        "provider_pay": providerPay == null ? null : providerPay,
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
