// To parse this JSON data, do
//
//     final helpResponse = helpResponseFromJson(jsonString);

import 'dart:convert';

class HelpResponse {
    HelpResponse({
        this.contactNumber,
        this.contactEmail,
    });

    String contactNumber;
    String contactEmail;

    factory HelpResponse.fromRawJson(String str) => HelpResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HelpResponse.fromJson(Map<String, dynamic> json) => HelpResponse(
        contactNumber: json["contact_number"] == null ? null : json["contact_number"],
        contactEmail: json["contact_email"] == null ? null : json["contact_email"],
    );

    Map<String, dynamic> toJson() => {
        "contact_number": contactNumber == null ? null : contactNumber,
        "contact_email": contactEmail == null ? null : contactEmail,
    };
}
