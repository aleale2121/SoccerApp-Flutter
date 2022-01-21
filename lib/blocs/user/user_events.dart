import 'package:equatable/equatable.dart';
import '../../models/model.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
  @override
  List<Object> get props => [];
}

class LoadUsers extends UsersEvent {}

class AddUser extends UsersEvent {
  final UsersInfo user;
  AddUser({required this.user});
  @override
  List<Object> get props => [user];
}

class UpdateUser extends UsersEvent {
  final UsersInfo user;
  const UpdateUser({required this.user});
  @override
  List<Object> get props => [user];
}

class DeleteUser extends UsersEvent {
  final String userId;
  const DeleteUser({required this.userId});

  @override
  List<Object> get props => [userId];
}

class Updatepassword extends UsersEvent {
  final UsersInfo userInfo;
  final String oldPassword;
  const Updatepassword({required this.oldPassword, required this.userInfo});
  @override
  List<Object> get props => [userInfo, oldPassword];
}

class UsersUpdated extends UsersEvent {
  final List<UsersInfo> users;
  const UsersUpdated({
    required this.users,
  });
  @override
  List<Object> get props => [users];
}
