import 'dart:convert';

// Konversi dari JSON ke List<SearchResponse>
List<SearchResponse> searchResponseFromJson(String str) {
  final List<dynamic> jsonData = json.decode(str);
  return jsonData.map((item) => SearchResponse.fromJson(item)).toList();
}

// Konversi dari List<SearchResponse> ke JSON String
String searchResponseToJson(List<SearchResponse> data) {
  final List<Map<String, dynamic>> jsonData =
      data.map((item) => item.toJson()).toList();
  return json.encode(jsonData);
}

// Model SearchResponse
class SearchResponse {
  final int id;
  final String contactName;
  final String contactPhone;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  SearchResponse({
    required this.id,
    required this.contactName,
    required this.contactPhone,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method untuk parsing JSON
  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      id: json["id"],
      contactName: json["contact_name"],
      contactPhone: json["contact_phone"],
      userId: json["user_id"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "contact_name": contactName,
      "contact_phone": contactPhone,
      "user_id": userId,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }

  // Tambahkan metode toString() untuk debugging
  @override
  String toString() {
    return 'SearchResponse(id: $id, contactName: $contactName, contactPhone: $contactPhone)';
  }
}
