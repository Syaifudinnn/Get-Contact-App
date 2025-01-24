import 'package:dio/dio.dart';

class ApiException extends DioException {
  ApiException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred';
  }
}

class BadRequestException extends ApiException {
  BadRequestException(super.r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class DeadlineExceededException extends ApiException {
  DeadlineExceededException(super.r);

  @override
  String toString() {
    return 'Request timeout';
  }
}

class NotFoundException extends ApiException {
  NotFoundException(super.r);

  @override
  String toString() {
    return 'Resource not found';
  }
}

class ConflictException extends ApiException {
  ConflictException(super.r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(super.r);

  @override
  String toString() {
    return 'Internal server error';
  }
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException(super.r);

  @override
  String toString() {
    return 'No internet connection';
  }
}
