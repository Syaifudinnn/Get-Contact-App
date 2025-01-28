// To parse this JSON data, do
//
//     final contactResponse = contactResponseFromJson(jsonString);

import 'dart:convert';

ContactResponse contactResponseFromJson(String str) =>
    ContactResponse.fromJson(json.decode(str));

String contactResponseToJson(ContactResponse data) =>
    json.encode(data.toJson());

class ContactResponse {
  List<Contact>? data;

  ContactResponse({
    this.data,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(
        data: json["data"] == null
            ? []
            : List<Contact>.from(json["data"]!.map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Contact {
  int? id;
  String? contactName;
  String? contactPhone;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contact({
    this.id,
    this.contactName,
    this.contactPhone,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_name": contactName,
        "contact_phone": contactPhone,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
