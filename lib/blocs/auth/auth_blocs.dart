import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../blocs/auth/auth.dart';
import '../../repository/user_repository.dart';
import '../../util/util.dart';
import '../../models/model.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final UserRepository userRepository;
  final Util util;
  AuthBloc({@required this.userRepository, @required this.util})
      : assert(userRepository != null),
        super(AuthUninitializedState());
  @override
  Stream<AuthStates> mapEventToState(AuthEvents event) async* {
    if (event is AutoLoginEvent) {
      yield* _mapAutoLoginEventToState();
    } else if (event is LoginEvent) {
      yield* _mapLoginEventToState(event.user);
    } else if (event is SignUpEvent) {
      yield* _mapSignUpEventToState(event.user);
    } else {
      return;
    }
  }

  Stream<AuthStates> _mapLoginEventToState(User user) async* {
    yield LoggingState();
    User u;
    try {
      u = await userRepository.login(user);
      await util.storeUserInformation(u);
      yield LoginSuccessState(user: u);
    } on HttpException catch (e) {
      if (e.message == 'Incorrect username or password') {
        yield IncorrectUsernameOrPasswordState();
      } else if (e.message == 'Invalid Input') {
        yield InvalidInputState();
      } else {
        yield LoginFailedState();
      }
    } catch (e) {
      yield LoginFailedState();
    }
  }

  Stream<AuthStates> _mapSignUpEventToState(User user) async* {
    yield SigningUpState();
    User u;
    try {
      u = await userRepository.signUp(user);
      yield SignUpSuccessState(user: u);
    } on HttpException catch (e) {
      if (e.message == 'Email already exists!') {
        yield EmailAlreadyExistState();
      } else if (e.message == 'Phone No already exists!') {
        yield PhoneAlreadyExistState();
      } else {
        yield SignUpFailedState();
      }
    } catch (e) {
      yield SignUpFailedState();
    }
  }

  Stream<AuthStates> _mapAutoLoginEventToState() async* {
    yield AutoLoginState();
    try {
      String token = await util.getUserToken();
      if (token == null) {
        yield AutoLoginFailedState();
        return;
      }
      String expiry = await util.getUserToken();
      if (expiry == null) {
        yield AutoLoginFailedState();
        return;
      }
      bool isExpired = util.isExpired(expiry);
      if (isExpired) {
        yield AutoLoginFailedState();
        return;
      } else {
        User user = await util.getUserInformation();
        yield AutoLoginSuccessState(user: user);
      }
    } catch (e) {
      yield AutoLoginFailedState();
    }
  }
}
