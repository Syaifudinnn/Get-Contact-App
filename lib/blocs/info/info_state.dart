part of 'info_bloc.dart';

sealed class InfoState extends Equatable {
  const InfoState();
  @override
  List<Object> get props => [];
}

final class InfoInitial extends InfoState {}

final class InfoLoading extends InfoState {}

final class InfoLoaded extends InfoState {
  final List<SearchResponse> contacts;
  const InfoLoaded(this.contacts);
  
  @override
  List<Object> get props => [contacts];
}

final class InfoError extends InfoState {
  final String message;
  const InfoError(this.message);
  @override
  List<Object> get props => [message];
}
