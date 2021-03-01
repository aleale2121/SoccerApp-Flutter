import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:soccer_app/repository/repository.dart';
import '../../models/user.dart';
import '../../models/http_exception.dart';
import '../../repository/role_repository.dart';
import 'role_events.dart';
import 'role_state.dart';

class RoleBloc extends Bloc<RoleEvents, RoleStates> {
  final RoleRepository roleRepository;

  RoleBloc({@required this.roleRepository}) : super(RoleUninitializedState());

  @override
  Stream<RoleStates> mapEventToState(RoleEvents event) async* {
    if (event is GetRoleEvent) {
      yield* _mapGetRoleEventToState();
    } else if (event is PostRoleEvent) {
      yield* _mapPostRoleEventToState(event.role);
    } else if (event is UpdateRoleEvent) {
      yield* _mapUpdateRoleEventToState(event.role);
    } else if (event is DeleteRoleEvent) {
      yield* _mapDeleteRoleEventToState(event.RoleId);
    }
  }

  Stream<RoleStates> _mapGetRoleEventToState() async* {
    yield RoleFetchingState();
    try {
      List<Role> roles = await roleRepository.getAndSetRoles();
      if (roles.length == 0) {
        print("hhhhhhhhhh" + '$roles');
        yield RoleEmptyState();
      } else {
        print("fetched state....");
        yield RoleFetchedState(roles: roles);
        print("fetched state finished....");
      }
    } on HttpException catch (e) {
      yield RoleFetchingErrorState(message: e.message);
    } catch (e) {
      yield RoleFetchingErrorState();
    }
  }

  Stream<RoleStates> _mapPostRoleEventToState(Role role) async* {
    yield RolePostingState();
    try {
      await roleRepository.postRole(role);
      yield RolePostedState();
    } on HttpException catch (e) {
      yield RolePostingErrorState(message: e.message);
    } catch (e) {
      yield RolePostingErrorState();
    }
  }

  Stream<RoleStates> _mapUpdateRoleEventToState(Role role) async* {
    yield RoleUpdatingState();
    try {
      await roleRepository.putRole(role);
      yield RoleUpdatedState();
    } on HttpException catch (e) {
      yield RoleUpdatingErrorState(message: e.message);
    } catch (e) {
      yield RoleUpdatingErrorState();
    }
  }

  Stream<RoleStates> _mapDeleteRoleEventToState(String roleId) async* {
    yield RoleDeletingState();
    try {
      await roleRepository.deleteRole(roleId);
      yield RoleDeletedState();
    } on HttpException catch (e) {
      yield RoleDeletingErrorState(message: e.message);
    } catch (e) {
      yield RoleDeletingErrorState();
    }
  }
}
