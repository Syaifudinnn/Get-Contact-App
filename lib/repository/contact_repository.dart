import 'package:get_contact_app/core/network/exeption/api_exeption.dart';
import 'package:get_contact_app/core/service/api_service.dart';
import 'package:get_contact_app/models/contact_response.dart';

class ContactRepository {
  final ApiService _apiService;

  ContactRepository() : _apiService = ApiService();

  Future<List<Contact>> fetchContacts() async {
    return _handleApiCall(() async {
      final response = await _apiService.getContacts();
      return (response.data as List)
          .map((json) => Contact.fromJson(json))
          .toList();
    });
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
