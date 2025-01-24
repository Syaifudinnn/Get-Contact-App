part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

//add login in progress state
final class LoginInProgress extends LoginState {}

//add login success state
final class LoginSuccess extends LoginState {}

//add login failure state
final class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
