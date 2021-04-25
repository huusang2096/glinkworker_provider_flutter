// To parse this JSON data, do
//
//     final documentResponse = documentResponseFromJson(jsonString);

import 'dart:convert';

class DocumentResponse {
    DocumentResponse({
        this.documents,
    });

    List<Document> documents;

    factory DocumentResponse.fromRawJson(String str) => DocumentResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DocumentResponse.fromJson(Map<String, dynamic> json) => DocumentResponse(
        documents: json["documents"] == null ? null : List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "documents": documents == null ? null : List<dynamic>.from(documents.map((x) => x.toJson())),
    };
}

class Document {
    Document({
        this.id,
        this.name,
        this.type,
        this.providerdocuments,
    });

    int id;
    String name;
    String type;
    Providerdocuments providerdocuments;

    factory Document.fromRawJson(String str) => Document.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        providerdocuments: json["providerdocuments"] == null ? null : Providerdocuments.fromJson(json["providerdocuments"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "providerdocuments": providerdocuments == null ? null : providerdocuments.toJson(),
    };
}

class Providerdocuments {
    Providerdocuments({
        this.url,
        this.status,
        this.documentId,
    });

    String url;
    String status;
    String documentId;

    factory Providerdocuments.fromRawJson(String str) => Providerdocuments.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Providerdocuments.fromJson(Map<String, dynamic> json) => Providerdocuments(
        url: json["url"] == null ? null : json["url"],
        status: json["status"] == null ? null : json["status"],
        documentId: json["document_id"] == null ? null : json["document_id"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "status": status == null ? null : status,
        "document_id": documentId == null ? null : documentId,
    };
}
