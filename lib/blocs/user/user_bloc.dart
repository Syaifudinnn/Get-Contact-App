import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_contact_app/repository/user_repository.dart';
import 'package:get_contact_app/models/user_response.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserLoading()) {
    on<FetchUserProfile>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.fetchUserProfile();
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError('Failed to fetch user data: ${e.toString()}'));
      }
    });

    on<UpdateUserVisibility>((event, emit) async {
      try {
        await userRepository.updateVisibility(event.userId, event.visibility);
        add(FetchUserProfile()); // Refresh user data
      } catch (e) {
        emit(UserError('Failed to update visibility: ${e.toString()}'));
      }
    });

    on<UpdateSpamProtection>((event, emit) async {
      try {
        await userRepository.updateSpamProtection(
            event.userId, event.isEnabled);
        add(FetchUserProfile()); // Refresh user data
      } catch (e) {
        emit(UserError('Failed to update spam protection: ${e.toString()}'));
      }
    });
  }
}
