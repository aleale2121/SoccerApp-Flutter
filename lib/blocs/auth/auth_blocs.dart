import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soccer_app/models/login_request.dart';
import '../../blocs/auth/auth.dart';
import '../../repository/user_repository.dart';
import '../../util/util.dart';
import '../../models/model.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final UserRepository userRepository;
  final Util util;

  AuthBloc({required this.userRepository, required this.util})
      : super(AuthUninitializedState());

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

  Stream<AuthStates> _mapLoginEventToState(LoginRequestModel user) async* {
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
        yield LoginFailedState(message: "");
      }
    } catch (e) {
      yield LoginFailedState(message: "");
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
        yield SignUpFailedState(message: "");
      }
    } catch (e) {
      yield SignUpFailedState(message: "");
    }
  }

  Stream<AuthStates> _mapAutoLoginEventToState() async* {
    yield AutoLoginState();
    try {
      String token = await util.getUserToken();
      if (token == null) {
        yield AutoLoginFailedState(message: "");
        return;
      }
      String expiry = await util.getUserToken();
      if (expiry == null) {
        yield AutoLoginFailedState(message: "");
        return;
      }
      bool isExpired = util.isExpired(expiry);
      if (isExpired) {
        yield AutoLoginFailedState(message: "");
        return;
      } else {
        User user = await util.getUserInformation();
        yield AutoLoginSuccessState(user: user);
      }
    } catch (e) {
      yield AutoLoginFailedState(message: "");
    }
  }
}
