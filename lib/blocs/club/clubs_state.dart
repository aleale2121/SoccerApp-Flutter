import 'package:equatable/equatable.dart';
import '../../models/club.dart';

abstract class ClubsState extends Equatable {
  const ClubsState();

  @override
  List<Object> get props => [];
}

class ClubsFetchingState extends ClubsState {}

class ClubFetchedState extends ClubsState {
  final List<Club> clubs;
  ClubFetchedState({required this.clubs});
}

class ClubsFetchingErrorState extends ClubsState {
  final String message;

  ClubsFetchingErrorState({required this.message});
}

class ClubDeletingState extends ClubsState {}

class ClubDeletedState extends ClubsState {}

class ClubsDeletingErrorState extends ClubsState {
  final String message;

  ClubsDeletingErrorState({required this.message});
}

class ClubPostingState extends ClubsState {}

class ClubPostedState extends ClubsState {}

class ClubPostingErrorState extends ClubsState {
  final String message;

  ClubPostingErrorState({required this.message});
}

class ClubUpdatingState extends ClubsState {}

class ClubUpdatedState extends ClubsState {}

class ClubUpdatingErrorState extends ClubsState {
  final String message;
  ClubUpdatingErrorState({required this.message});
}

class ClubsEmptyState extends ClubsState {}
