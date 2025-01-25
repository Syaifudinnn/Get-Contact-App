import 'package:dio/dio.dart';
import 'package:get_contact_app/core/network/dio_client.dart';
import 'package:get_contact_app/core/config/api_config.dart';
import 'package:get_contact_app/models/login_response.dart';

class AuthenticationRepository {
  final DioClient _dioClient = DioClient();

  // Fungsi untuk login user
  Future<LoginResponse> loginUser(String email, String password) async {
    return _handleApiCall(() async {
      final response = await _dioClient.post(
        ApiConfig.login,
        data: {'email': email, 'password': password},
      );
      return LoginResponse.fromJson(response.data);
    });
  }

  // Fungsi untuk menangani panggilan API dan exception
  Future<T> _handleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      // Cek jenis error dari Dio
      if (e.response != null) {
        // Response error dari server
        throw Exception('Error: ${e.response?.data['message']}');
      } else {
        // Error lain selain server response
        throw Exception('Network error: ${e.message}');
      }
    }
  }
}
