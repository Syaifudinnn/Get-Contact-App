import 'package:get_contact_app/core/network/exeption/api_exeption.dart';
import 'package:get_contact_app/core/service/api_service.dart';
import 'package:get_contact_app/models/user_response.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository() : _apiService = ApiService();

  Future<UserResponse> fetchUserProfile() async {
    return _handleApiCall(() async {
      final response = await _apiService.getUserProfile();
      return response;
    });
  }

  Future<void> updateVisibility(String userId, String visibility) async {
    return _handleApiCall(() async {
      await _apiService.updateUserVisibility(userId, visibility);
    });
  }

  Future<void> updateSpamProtection(String userId, bool isEnabled) async {
    return _handleApiCall(() async {
      await _apiService.updateSpamProtection(userId, isEnabled);
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
