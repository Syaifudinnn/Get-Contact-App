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

  //update user visibility
  Future<void> updateUserVisibility(String visibility) async {
    try {
      await _dioClient.put(
        ApiConfig.user,
        data: {"tag_visibility": visibility},
      );
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Failed to update visibility');
    }
  }
}
