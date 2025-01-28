import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../network/dio_client.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService() : _dioClient = DioClient();

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
}
