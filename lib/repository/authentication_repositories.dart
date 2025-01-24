import 'package:dio/dio.dart';
import 'package:get_contact_app/core/network/dio_client.dart';
import 'package:get_contact_app/core/config/api_config.dart';
import '../models/login_response.dart';

class AuthenticationRepository {
  final DioClient _dioClient = DioClient();

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      final response = await _dioClient.post(
        ApiConfig.login,
        data: {'email': email, 'password': password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.response?.data['message']}');
    }
  }
}
