part of 'info_bloc.dart';

sealed class InfoEvent extends Equatable {
  const InfoEvent();
  @override
  List<Object> get props => [];
}

final class SearchContact extends InfoEvent {
  final String query;
  const SearchContact(this.query);
  @override
  List<Object> get props => [query];
}