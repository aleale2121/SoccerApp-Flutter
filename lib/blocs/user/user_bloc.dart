import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soccer_app/models/custom_exception.dart';
import '../../repository/repository.dart';
import '../../models/user.dart';
import '../../repository/user_repository.dart';
import 'user_states.dart';
import 'user_events.dart';

class UserBloc extends Bloc<UsersEvent, UserStates> {
  final UserRepository _userRepository;
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserUninitializedState()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateUser>(_onUpdateUser);
    on<Updatepassword>(_onUpdatePassword);
    on<UsersUpdated>(_onUsersUpdated);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserStates> emit) {
    return emit.onEach<List<UsersInfo>>(
      _userRepository.users(),
      onData: (users) => add(UsersUpdated(users: users)),
    );
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserStates> emit) {
    emit(UserUpdatingState());
    try {
      _userRepository.updateUser(event.user);
      emit(UserUpdatedState());
    } on CustomException catch (e) {
      emit(UserUpdatingErrorState(message: e.cause));
    } catch (e) {
      emit(UserUpdatingErrorState(message: "Failed To Update User"));
    }
  }

  void _onUpdatePassword(Updatepassword event, Emitter<UserStates> emit) {
    emit(UserUpdatingState());
    try {
      _userRepository.updatePassword(event.userInfo);
      emit(UserUpdatedState());
    } on CustomException catch (e) {
      emit(UserUpdatingErrorState(message: e.cause));
    } catch (e) {
      emit(UserUpdatingErrorState(message: "Failed To Update Password"));
    }
  }

  void _onUsersUpdated(UsersUpdated event, Emitter<UserStates> emit) {
    emit(UsersFetchedState(users: event.users));
  }
}
