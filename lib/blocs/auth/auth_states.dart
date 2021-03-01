import 'package:flutter/foundation.dart';
import '../../models/model.dart';

abstract class AuthStates {}

class AuthUninitializedState extends AuthStates {}

class AutoLoginState extends AuthStates {}

class AutoLoginSuccessState extends AuthStates {
  final User user;
  AutoLoginSuccessState({@required this.user});
}

class AutoLoginFailedState extends AuthStates {
  final String message;
  AutoLoginFailedState({this.message});
}

class LoggingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final User user;
  LoginSuccessState({@required this.user});
}

class LoginFailedState extends AuthStates {
  final String message;
  LoginFailedState({this.message});
}

class SigningUpState extends AuthStates {}

class SignUpSuccessState extends AuthStates {
  final User user;
  SignUpSuccessState({@required this.user});
}

class EmailAlreadyExistState extends AuthStates {}

class PhoneAlreadyExistState extends AuthStates {}

class IncorrectUsernameOrPasswordState extends AuthStates {}

class InvalidInputState extends AuthStates {}

class SignUpFailedState extends AuthStates {
  final String message;
  SignUpFailedState({this.message});
}

class LoggingOutState extends AuthStates {}

class LoggingOutSuccessState extends AuthStates {}

class LoggingOutErrorState extends AuthStates {}
