import 'package:flutter/foundation.dart';
import '../../models/model.dart';

abstract class UserStates {}

class UserUninitializedState extends UserStates {}

class UsersFetchingState extends UserStates {}

class UsersFetchedState extends UserStates {
  final List<User> users;
  UsersFetchedState({@required this.users});
}

class UsersFetchingErrorState extends UserStates {
  final String message;

  UsersFetchingErrorState({this.message});
}

class UserPostingState extends UserStates {}

class UserPostedState extends UserStates {}

class UserPostingErrorState extends UserStates {
  final String message;

  UserPostingErrorState({this.message});
}

class UserDeletingState extends UserStates {}

class UserDeletedState extends UserStates {}

class UserDeletingErrorState extends UserStates {
  final String message;

  UserDeletingErrorState({this.message});
}

class UserSigningUpState extends UserStates {}

class UserSignedUpState extends UserStates {}

class UserSigningUpErrorState extends UserStates {
  final String message;

  UserSigningUpErrorState({this.message});
}

class UserUpdatingState extends UserStates {}

class UserUpdatedState extends UserStates {}

class UserUpdatingErrorState extends UserStates {
  final String message;
  UserUpdatingErrorState({this.message});
}

class UserIncorrectOldPasswordState extends UserStates {}

class UsersEmptyState extends UserStates {}
