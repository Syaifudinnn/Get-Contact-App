// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  Settings? settings;

  UserResponse({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.settings,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "settings": settings?.toJson(),
      };
}

class Settings {
  bool? spamProtectionEnabled;
  String? tagVisibility;

  Settings({
    this.spamProtectionEnabled,
    this.tagVisibility,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        spamProtectionEnabled: json["spam_protection_enabled"],
        tagVisibility: json["tag_visibility"],
      );

  Map<String, dynamic> toJson() => {
        "spam_protection_enabled": spamProtectionEnabled,
        "tag_visibility": tagVisibility,
      };
}
