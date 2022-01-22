import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/view/users_screen/admin_users_screen.dart';
import 'package:soccer_app/view/auth_screens/change_password_screen.dart';
import 'package:soccer_app/view/auth_screens/change_username_screen.dart';
import 'package:soccer_app/view/auth_screens/user_delete_account.dart';
import '../models/model.dart';
import '../blocs/auth/auth.dart';
import '../view/view_fixture_detail_screen/admin_fixture_detail_screen.dart';
import '../view/view_result_detail_screen/admin_result_detail_screen.dart';
import '../view/view_fixture_detail_screen/user_fixture_detail_screen.dart';
import '../view/view_result_detail_screen/user_result_detail_screen.dart';
import '../view/auth_screens/signup_screen.dart';
import '../view/splash_screen.dart';
import '../view/home_screen/admin_home_screen.dart';
import '../view/auth_screens/login_screen.dart';
import '../view/home_screen/user_home_screen.dart';
import '../view/edit_fixture_screen/admin_add_schedule.dart';
import '../view/edit_result_screen/admin_add_result.dart';

bool isAuthenticated = false;
bool isAdmin = false;

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => BlocBuilder<AuthBloc, AuthStates>(
          builder: (context, state) {
            if (state is AutoLoginState) {
              return SplashScreen(title: 'Authenticating');
            } else if (state is AutoLoginSuccessState) {
              isAdmin = state.user.role.toUpperCase() == 'ADMIN';
              isAuthenticated = true;
            } else if (state is AutoLoginFailedState) {
              isAuthenticated = false;
            } else if (state is LoggingOutState) {
              return SplashScreen(title: 'Logging out');
            } else if (state is LoggingOutSuccessState) {
              isAuthenticated = false;
            } else if (state is LoggingOutErrorState) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('An Error Occurred!'),
                  content: Text('Failed to log out'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    )
                  ],
                ),
              );
            }
            return isAuthenticated
                ? (isAdmin ? AdminHome() : UserHome())
                : LoginScreen();
          },
        ),
      );
    }

    if (settings.name == LoginScreen.routeName) {
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }
    if (settings.name == SignUpScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    }
    if (settings.name == AdminHome.routeName) {
      return MaterialPageRoute(builder: (context) => AdminHome());
    }

    if (settings.name == FixtureAddUpdate.routeName) {
      FixtureRoutArgs fixtureRoutArgs = settings.arguments as FixtureRoutArgs;
      return MaterialPageRoute(
          builder: (context) => FixtureAddUpdate(
                fixtureArgs: fixtureRoutArgs,
              ));
    }
    if (settings.name == ResultAddUpdate.routeName) {
      ResultRoutArgs resultRoutArgs = settings.arguments as ResultRoutArgs;
      return MaterialPageRoute(
          builder: (context) => ResultAddUpdate(
                resultArgs: resultRoutArgs,
              ));
    }

    if (settings.name == AdminUsersScreen.routeName) {
      return MaterialPageRoute(builder: (context) => AdminUsersScreen());
    }

    if (settings.name == PasswordChangeScreen.routeName) {
      UsersInfo user = settings.arguments as UsersInfo;
      return MaterialPageRoute(
          builder: (context) => PasswordChangeScreen(
                user: user,
              ));
    }
    if (settings.name == UsernameChangeScreen.routeName) {
      UsersInfo user = settings.arguments as UsersInfo;
      print('username change');
      return MaterialPageRoute(
          builder: (context) => UsernameChangeScreen(
                user: user,
              ));
    }

    if (settings.name == DeleteAccountPage.routeName) {
      // RoleRoutArgs roleRoutArgs = settings.arguments;
      return MaterialPageRoute(builder: (context) => DeleteAccountPage());
    }

    if (settings.name == AdminFixtureDetail.routeName) {
      FixtureRoutArgsForDetail fixture =
          settings.arguments as FixtureRoutArgsForDetail;
      return MaterialPageRoute(
          builder: (context) => AdminFixtureDetail(
                fixture: fixture,
              ));
    }

    if (settings.name == AdminResultDetail.routeName) {
      ResultRoutArgsForDetail result =
          settings.arguments as ResultRoutArgsForDetail;
      return MaterialPageRoute(
          builder: (context) => AdminResultDetail(
                result: result,
              ));
    }

    if (settings.name == UserFixtureDetail.routeName) {
      FixtureRoutArgsForDetail fixture =
          settings.arguments as FixtureRoutArgsForDetail;
      return MaterialPageRoute(
          builder: (context) => UserFixtureDetail(
                fixture: fixture,
              ));
    }
    if (settings.name == UserResultDetail.routeName) {
      ResultRoutArgsForDetail result =
          settings.arguments as ResultRoutArgsForDetail;
      return MaterialPageRoute(
          builder: (context) => UserResultDetail(
                result: result,
              ));
    }
    return MaterialPageRoute(builder: (context) => UserHome());
  }
}

class FixtureRoutArgs {
  Fixture? fixture;
  final bool edit;

  FixtureRoutArgs({
    this.fixture,
    required this.edit,
  });
}

class ResultRoutArgs {
  final Result? result;
  final Fixture? fixture;
  final bool edit;

  ResultRoutArgs({
    this.result,
    this.fixture,
    required this.edit,
  });
}

class FixtureRoutArgsForDetail {
  final Fixture fixture;
  FixtureRoutArgsForDetail({required this.fixture});
}

class ResultRoutArgsForDetail {
  final Result result;
  ResultRoutArgsForDetail({required this.result});
}
