// To parse this JSON data, do
//
//     final walletTransactionResponse = walletTransactionResponseFromJson(jsonString);

import 'dart:convert';
import 'package:simplest/simplest.dart';

class WalletTransactionResponse {
  WalletTransactionResponse({
    this.walletTransation,
    this.walletBalance,
  });

  List<WalletTransation> walletTransation;
  double walletBalance;

  factory WalletTransactionResponse.fromRawJson(String str) =>
      WalletTransactionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletTransactionResponse.fromJson(Map<String, dynamic> json) =>
      WalletTransactionResponse(
        walletTransation: json["wallet_transation"] == null
            ? null
            : List<WalletTransation>.from(json["wallet_transation"]
                .map((x) => WalletTransation.fromJson(x))),
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "wallet_transation": walletTransation == null
            ? null
            : List<dynamic>.from(walletTransation.map((x) => x.toJson())),
        "wallet_balance": walletBalance == null ? null : walletBalance,
      };
}

class WalletTransation {
  WalletTransation({
    this.transactionAlias,
    this.amount,
    this.createdAt,
    this.transactions,
  });

  String transactionAlias;
  double amount;
  DateTime createdAt;
  List<Transaction> transactions;

  factory WalletTransation.fromRawJson(String str) =>
      WalletTransation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletTransation.fromJson(Map<String, dynamic> json) =>
      WalletTransation(
        transactionAlias: json["transaction_alias"] == null
            ? null
            : json["transaction_alias"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        transactions: json["transactions"] == null
            ? null
            : List<Transaction>.from(
                json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transaction_alias": transactionAlias == null ? null : transactionAlias,
        "amount": amount == null ? null : amount,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "transactions": transactions == null
            ? null
            : List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.id,
    this.providerId,
    this.transactionId,
    this.transactionAlias,
    this.transactionDesc,
    this.type,
    this.amount,
    this.openBalance,
    this.closeBalance,
    this.paymentMode,
    this.createdAt,
  });

  int id;
  int providerId;
  int transactionId;
  String transactionAlias;
  String transactionDesc;
  String type;
  double amount;
  double openBalance;
  double closeBalance;
  String paymentMode;
  DateTime createdAt;

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        transactionAlias: json["transaction_alias"] == null
            ? null
            : json["transaction_alias"],
        transactionDesc:
            json["transaction_desc"] == null ? null : json["transaction_desc"],
        type: json["type"] == null ? null : json["type"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        openBalance: json["open_balance"] == null
            ? null
            : json["open_balance"].toDouble(),
        closeBalance: json["close_balance"] == null
            ? null
            : json["close_balance"].toDouble(),
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "transaction_id": transactionId == null ? null : transactionId,
        "transaction_alias": transactionAlias == null ? null : transactionAlias,
        "transaction_desc": transactionDesc == null ? null : transactionDesc,
        "type": type == null ? null : type,
        "amount": amount == null ? null : amount,
        "open_balance": openBalance == null ? null : openBalance,
        "close_balance": closeBalance == null ? null : closeBalance,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
