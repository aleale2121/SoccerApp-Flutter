import 'package:flutter/foundation.dart';
import '../../models/user.dart';

abstract class RoleStates {}

class RoleUninitializedState extends RoleStates {}

class RoleFetchingState extends RoleStates {}

class RoleFetchedState extends RoleStates {
  final List<Role> roles;
  RoleFetchedState({@required this.roles}):assert(roles!=null);

  @override
  List<Object> get props => [roles];


}

class RoleFetchingErrorState extends RoleStates {
  final String message;

  RoleFetchingErrorState({this.message});
}

class RoleDeletingState extends RoleStates {}

class RoleDeletedState extends RoleStates {}

class RoleDeletingErrorState extends RoleStates {
  final String message;

  RoleDeletingErrorState({this.message});
}

class RolePostingState extends RoleStates {}

class RolePostedState extends RoleStates {}

class RolePostingErrorState extends RoleStates {
  final String message;

  RolePostingErrorState({this.message});
}

class RoleUpdatingState extends RoleStates {}

class RoleUpdatedState extends RoleStates {}

class RoleUpdatingErrorState extends RoleStates {
  final String message;
  RoleUpdatingErrorState({this.message});
}

class RoleEmptyState extends RoleStates {}
