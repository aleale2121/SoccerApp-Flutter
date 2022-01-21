import 'package:equatable/equatable.dart';

import '../../models/model.dart';

abstract class AuthStates extends Equatable {
  const AuthStates();
  @override
  List<Object> get props => [];
}

class AuthUninitializedState extends AuthStates {}

class AutoLoginState extends AuthStates {}

class AutoLoginSuccessState extends AuthStates {
  final UsersInfo user;
  AutoLoginSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class AutoLoginFailedState extends AuthStates {
  final String message;
  AutoLoginFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoggingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final UsersInfo user;
  LoginSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginFailedState extends AuthStates {
  final String message;
  LoginFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

class SigningUpState extends AuthStates {}

class SignUpSuccessState extends AuthStates {
  final UsersInfo user;
  SignUpSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}

class EmailAlreadyExistState extends AuthStates {}

class PhoneAlreadyExistState extends AuthStates {}

class IncorrectUsernameOrPasswordState extends AuthStates {}

class InvalidInputState extends AuthStates {}

class SignUpFailedState extends AuthStates {
  final String message;
  SignUpFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoggingOutState extends AuthStates {}

class LoggingOutSuccessState extends AuthStates {}

class LoggingOutErrorState extends AuthStates {}
