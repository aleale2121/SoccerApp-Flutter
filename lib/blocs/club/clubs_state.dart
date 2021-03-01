import 'package:flutter/foundation.dart';
import '../../models/club.dart';

abstract class ClubStates {}

class ClubUninitializedState extends ClubStates {}

class ClubsFetchingState extends ClubStates {}

class ClubFetchedState extends ClubStates {
  final List<Club> clubs;
  ClubFetchedState({@required this.clubs});
}

class ClubsFetchingErrorState extends ClubStates {
  final String message;

  ClubsFetchingErrorState({this.message});
}

class ClubDeletingState extends ClubStates {}

class ClubDeletedState extends ClubStates {}

class ClubsDeletingErrorState extends ClubStates {
  final String message;

  ClubsDeletingErrorState({this.message});
}

class ClubPostingState extends ClubStates {}

class ClubPostedState extends ClubStates {}

class ClubPostingErrorState extends ClubStates {
  final String message;

  ClubPostingErrorState({this.message});
}

class ClubUpdatingState extends ClubStates {}

class ClubUpdatedState extends ClubStates {}

class ClubUpdatingErrorState extends ClubStates {
  final String message;
  ClubUpdatingErrorState({this.message});
}

class ClubsEmptyState extends ClubStates {}
