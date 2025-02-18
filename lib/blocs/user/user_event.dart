part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserEvent {}

class UpdateUserVisibility extends UserEvent {
  final String userId;
  final String visibility;

  UpdateUserVisibility(this.userId, this.visibility);

  @override
  List<Object> get props => [userId, visibility];
}

class UpdateSpamProtection extends UserEvent {
  final String userId;
  final bool isEnabled;

  UpdateSpamProtection(this.userId, this.isEnabled);

  @override
  List<Object> get props => [userId, isEnabled];
}
