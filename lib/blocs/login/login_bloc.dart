import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      // TODO: implement event handler
      //create dummy login logic
      //add 2 second delay
      emit(LoginInProgress());
      await Future.delayed(const Duration(seconds: 2));
      if (event.email == 'admin' && event.password == 'admin') {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Invalid email or password'));
      }
    });
  }
}
