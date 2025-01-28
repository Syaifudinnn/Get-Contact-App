import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_contact_app/core/shared_preference/shared_preference.dart';
import 'package:get_contact_app/models/login_response.dart';
import 'package:get_contact_app/core/network/dio_client.dart';
import 'package:get_contact_app/core/config/api_config.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DioClient _dioClient;

  LoginBloc(this._dioClient) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginInProgress());

      try {
        final response = await _dioClient.post(
          ApiConfig.login,
          data: {
            'email': event.email,
            'password': event.password,
          },
        );

        if (response.statusCode == 200) {
          final loginResponse = LoginResponse.fromJson(response.data);

          if (loginResponse.data?.token != null) {
            await TokenManager.saveToken(loginResponse.data!.token!);
            emit(LoginSuccess(token: loginResponse.data!.token!));
          } else {
            emit(LoginFailure(error: 'Token not found in response'));
          }
        } else {
          emit(LoginFailure(error: 'Invalid email or password'));
        }
      } catch (e) {
        emit(LoginFailure(error: 'Failed to login: ${e.toString()}'));
      }
    });
  }
}
