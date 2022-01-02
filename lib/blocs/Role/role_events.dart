import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../models/user.dart';

abstract class RoleEvents extends Equatable {}

class GetRoleEvent extends RoleEvents {
  GetRoleEvent();
  @override
  List<Object> get props => [];
}

class PostRoleEvent extends RoleEvents {
  final Role role;
  PostRoleEvent({required this.role});
  @override
  List<Object> get props => [];
}

class UpdateRoleEvent extends RoleEvents {
  final Role role;
  UpdateRoleEvent({required this.role});
  @override
  List<Object> get props => [];
}

class DeleteRoleEvent extends RoleEvents {
  final String RoleId;
  DeleteRoleEvent({required this.RoleId});

  @override
  List<Object> get props => [];
}
