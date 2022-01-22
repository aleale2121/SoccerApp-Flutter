import 'package:bloc/bloc.dart';
import 'package:soccer_app/models/custom_exception.dart';
import 'package:soccer_app/shared/constants.dart';
import '../../blocs/auth/auth.dart';
import '../../repository/user_repository.dart';
import '../../models/model.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthUninitializedState()) {
    on<AutoLoginEvent>(_onAutoLogin);
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignup);
    on<LogOutEvent>(_onLogout);
  }

  void _onAutoLogin(AutoLoginEvent event, Emitter<AuthStates> emit) async {
    emit(AutoLoginState());
    UsersInfo? u;
    try {
      u = await _userRepository.autoLogin();
      emit(AutoLoginSuccessState(user: u!));
    } on HttpException catch (e) {
      emit(
        AutoLoginFailedState(
          message: errorMessages[e.message] != null
              ? errorMessages[e.message]!
              : "Failed To Login",
        ),
      );
    } on CustomException catch (e) {
      emit(AutoLoginFailedState(message: e.cause));
    } catch (e) {
      emit(AutoLoginFailedState(message: "Failed To Login"));
    }
  }

  void _onLogin(LoginEvent event, Emitter<AuthStates> emit) async {
    emit(LoggingState());
    UsersInfo? u;
    try {
      u = await _userRepository.login(event.user);
      emit(LoginSuccessState(user: u!));
    } on HttpException catch (e) {
      emit(
        LoginFailedState(
          message: errorMessages[e.message] != null
              ? errorMessages[e.message]!
              : "Failed To Login",
        ),
      );
    } on CustomException catch (e) {
      emit(LoginFailedState(message: e.cause));
    } catch (e) {
      emit(LoginFailedState(message: "Failed To Login"));
    }
  }

  void _onSignup(SignUpEvent event, Emitter<AuthStates> emit) async {
    emit(SigningUpState());
    try {
      await _userRepository.signUp(event.user);
      emit(SignUpSuccessState(user: event.user));
    } on HttpException catch (e) {
      emit(
        SignUpFailedState(
          message: errorMessages[e.message] != null
              ? errorMessages[e.message]!
              : "Failed To Signup",
        ),
      );
    } on CustomException catch (e) {
      emit(SignUpFailedState(message: e.cause));
    } catch (e) {
      emit(SignUpFailedState(message: "Failed To Signup"));
    }
  }

  void _onLogout(LogOutEvent event, Emitter<AuthStates> emit) async {
    await _userRepository.signOut();
    emit(LoggingOutSuccessState());
  }
}
