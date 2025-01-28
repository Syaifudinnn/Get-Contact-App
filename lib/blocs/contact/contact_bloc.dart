import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_contact_app/repository/contact_repository.dart';
import 'package:get_contact_app/models/contact_response.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc({required this.contactRepository})
      : super(ContactLoading()) {
    on<ContactFetch>((event, emit) async {
      emit(ContactLoading());
      try {
        final contacts = await contactRepository.fetchContacts();
        emit(ContactLoaded(contacts));
      } catch (e) {
        emit(ContactError(e.toString()));
      }
    });
  }
}
