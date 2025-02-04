import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_contact_app/models/search_response.dart';
import 'package:get_contact_app/repository/contact_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final ContactRepository contactRepository;

  InfoBloc({required this.contactRepository}) : super(InfoInitial()) {
    on<SearchContact>((event, emit) async {
      emit(InfoLoading());
      try {
        final contacts = await contactRepository.searchContacts(event.query);

        // Jika list kosong, kembalikan error
        if (contacts.isEmpty) {
          emit(InfoError("Data tidak ditemukan"));
        } else {
          emit(InfoLoaded(contacts));
        }
      } catch (e) {
        emit(InfoError("Gagal mencari kontak: ${e.toString()}"));
      }
    });
  }
}
