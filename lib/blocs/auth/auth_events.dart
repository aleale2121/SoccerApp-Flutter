import 'package:equatable/equatable.dart';
import '../../models/model.dart';

abstract class AuthEvents extends Equatable {
  const AuthEvents();
  @override
  List<Object> get props => [];
}

class AutoLoginEvent extends AuthEvents {}

class LoginEvent extends AuthEvents {
  final LoginRequestModel user;
  LoginEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class SignUpEvent extends AuthEvents {
  final UsersInfo user;
  SignUpEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class LogOutEvent extends AuthEvents {}
