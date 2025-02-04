import 'package:dio/dio.dart';
import 'package:get_contact_app/core/network/exeption/api_exeption.dart';
import 'package:get_contact_app/core/service/api_service.dart';
import 'package:get_contact_app/models/contact_response.dart';
import 'package:get_contact_app/models/search_response.dart';

class ContactRepository {
  final ApiService _apiService;

  ContactRepository() : _apiService = ApiService();

  Future<ContactResponse> fetchContacts() async {
    return _handleApiCall(() async {
      final response = await _apiService.getContacts();
      return ContactResponse.fromJson(response.data);
    });
  }

  Future<List<SearchResponse>> searchContacts(String query) async {
    try {
      final response = await _apiService.searchContacts(query);

      if (response.data is List) {
        return response.data
            .map<SearchResponse>((json) => SearchResponse.fromJson(json))
            .toList();
      } else {
        throw Exception("Format data dari server tidak valid");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Gagal mencari kontak');
    }
  }

  Future<T> _handleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on BadRequestException {
      throw Exception('Invalid request');
    } on UnauthorizedException {
      throw Exception('Access denied');
    } on NotFoundException {
      throw Exception('Resource not found');
    } on InternalServerErrorException {
      throw Exception('Internal server error');
    } on NoInternetConnectionException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Unknown error occurred');
    }
  }
}
