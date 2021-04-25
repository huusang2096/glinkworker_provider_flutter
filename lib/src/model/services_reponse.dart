import 'dart:convert';

class ServicesResponse {
  ServicesResponse({
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
    this.childrenRecursive,
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
  List<ServicesResponse> childrenRecursive;

  factory ServicesResponse.fromRawJson(String str) => ServicesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => ServicesResponse(
    id: json["id"] == null ? null : json["id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    name: json["name"] == null ? null : json["name"],
    providerName: json["provider_name"] == null ? null : json["provider_name"],
    image: json["image"] == null ? null : json["image"],
    marker: json["marker"] == null ? null : json["marker"],
    fixed: json["fixed"] == null ? null : json["fixed"],
    price: json["price"] == null ? null : json["price"],
    typePrice: json["type_price"] == null ? null : json["type_price"],
    calculator: json["calculator"] == null ? null : json["calculator"],
    description: json["description"],
    status: json["status"] == null ? null : json["status"],
    childrenRecursive: json["children_recursive"] == null ? null : List<ServicesResponse>.from(json["children_recursive"].map((x) => ServicesResponse.fromJson(x))),
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
    "children_recursive": childrenRecursive == null ? null : List<dynamic>.from(childrenRecursive.map((x) => x.toJson())),
  };
}