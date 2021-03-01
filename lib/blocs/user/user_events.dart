import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../models/model.dart';

abstract class UserEvents extends Equatable {}

class GetUsersEvent extends UserEvents {
  GetUsersEvent();
  @override
  List<Object> get props => [];
}

class PostUserEvent extends UserEvents {
  final User user;
  PostUserEvent({@required this.user});
  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UserEvents {
  final User user;
  UpdateUserEvent({@required this.user});
  @override
  List<Object> get props => [];
}

class DeleteUserEvent extends UserEvents {
  final String userId;
  DeleteUserEvent({@required this.userId});

  @override
  List<Object> get props => [];
}

class UpdateUserPasswordEvent extends UserEvents {
  final User user;
  final String oldPassword;
  UpdateUserPasswordEvent({@required this.oldPassword, @required this.user});
  @override
  List<Object> get props => [];
}
