import 'package:equatable/equatable.dart';

import '../../models/model.dart';

abstract class UserStates extends Equatable {
  const UserStates();

  @override
  List<Object> get props => [];
}

class UserUninitializedState extends UserStates {}

class UsersFetchingState extends UserStates {}

class UsersFetchedState extends UserStates {
  final List<UsersInfo> users;
  UsersFetchedState({required this.users});
  @override
  List<Object> get props => [users];
}

class UsersFetchingErrorState extends UserStates {
  final String message;

  UsersFetchingErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class UserPostingState extends UserStates {}

class UserPostedState extends UserStates {}

class UserPostingErrorState extends UserStates {
  final String message;

  UserPostingErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class UserDeletingState extends UserStates {}

class UserDeletedState extends UserStates {}

class UserDeletingErrorState extends UserStates {
  final String message;

  UserDeletingErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class UserSigningUpState extends UserStates {}

class UserSignedUpState extends UserStates {}

class UserSigningUpErrorState extends UserStates {
  final String message;

  UserSigningUpErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class UserUpdatingState extends UserStates {}

class UserUpdatedState extends UserStates {}

class UserUpdatingErrorState extends UserStates {
  final String message;
  UserUpdatingErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class UserIncorrectOldPasswordState extends UserStates {}

class UsersEmptyState extends UserStates {}
