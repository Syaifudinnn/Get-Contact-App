import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../network/dio_client.dart';
import '/models/user_response.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService() : _dioClient = DioClient();

  //get contacts
  Future<Response> getContacts() async {
    try {
      final response = await _dioClient.get(ApiConfig.contact);
      return response;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Unknown error occurred');
    }
  }

  //search contacts
  Future<Response> searchContacts(String query) async {
    try {
      final response = await _dioClient.get(
        ApiConfig.contactSearch,
        queryParameters: {'query': query},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Gagal mencari kontak');
    }
  }

  //get user profile
  Future<UserResponse> getUserProfile() async {
    try {
      final response = await _dioClient.get(ApiConfig.user);
      return UserResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Gagal mengambil profil pengguna');
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  //update User Visibility
  Future<void> updateUserVisibility(String userId, String visibility) async {
    try {
      final response = await _dioClient.put(
        ApiConfig.visibility, // Remove userId from URL
        data: {"user_id": userId, "tag_visibility": visibility},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update visibility: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print("ERROR: ${e.response?.statusCode} - ${e.message}");
      print("RESPONSE DATA: ${e.response?.data}");
      throw Exception(
          e.response?.data['message'] ?? 'Failed to update visibility');
    }
  }

  //update Spam Protection
  Future<void> updateSpamProtection(String userId, bool isEnabled) async {
    try {
      final response = await _dioClient.put(
        ApiConfig.spamProtect, // Remove userId from URL
        data: {"user_id": userId, "spam_protection_enabled": isEnabled},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update spam protection: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print("ERROR: ${e.response?.statusCode} - ${e.message}");
      print("RESPONSE DATA: ${e.response?.data}");
      throw Exception(
          e.response?.data['message'] ?? 'Failed to update spam protection');
    }
  }
}
