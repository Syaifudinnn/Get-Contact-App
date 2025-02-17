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
        emit(UserError('Failed to fetch user data'));
      }
    });
  }
}
