import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/screens/admin_manage_user_role_screen.dart';
import 'package:soccer_app/screens/admin_users_screen.dart';
import 'package:soccer_app/screens/change_password_screen.dart';
import 'package:soccer_app/screens/change_username_screen.dart';
import 'package:soccer_app/screens/user_delete_account.dart';
import 'package:soccer_app/util/util.dart';
import '../models/model.dart';
import '../blocs/auth/auth.dart';
import 'detailScreens/admin_fixture_detail_screen.dart';
import 'detailScreens/admin_result_detail_screen.dart';
import 'detailScreens/user_fixture_detail_screen.dart';
import 'detailScreens/user_result_detail_screen.dart';
import 'signup_screen.dart';
import 'admin_add_role_screen.dart';
import 'admin_role_screen.dart';
import 'splash_screen.dart';
import 'admin_home_screen.dart';
import 'login_screen.dart';
import 'user_home_screen.dart';
import 'admin_add_schedule.dart';
import 'admin_add_result.dart';

bool isAuthenticated = false;
bool isAdmin = false;

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
          builder: (context) =>
              BlocBuilder<AuthBloc, AuthStates>(builder: (context, state) {
                if (state is AutoLoginState) {
                  return SplashScreen(title: 'Authenticating');
                } else if (state is AutoLoginSuccessState) {
                  isAdmin = state.user.role.name.toUpperCase() == 'ADMIN';
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
                        FlatButton(
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
              }));
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
      FixtureRoutArgs fixtureRoutArgs = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FixtureAddUpdate(
                fixtureArgs: fixtureRoutArgs,
              ));
    }
    if (settings.name == ResultAddUpdate.routeName) {
      ResultRoutArgs resultRoutArgs = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => ResultAddUpdate(
                resultArgs: resultRoutArgs,
              ));
    }
    if (settings.name == RoleAdd.routeName) {
      return MaterialPageRoute(builder: (context) => RoleAdd());
    }
    if (settings.name == AdminRoleScreen.routeName) {
      return MaterialPageRoute(builder: (context) => AdminRoleScreen());
    }
    if (settings.name == AdminUsersScreen.routeName) {
      return MaterialPageRoute(builder: (context) => AdminUsersScreen());
    }
    if (settings.name == AdminEditUserRole.routeName) {
      User user = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AdminEditUserRole(
                user: user,
              ));
    }
    if (settings.name == PasswordChangeScreen.routeName) {
      User user = settings.arguments;
      print('password change');
      print(user.fullName.toString());
      return MaterialPageRoute(
          builder: (context) => PasswordChangeScreen(
                user: user,
              ));
    }
    if (settings.name == UsernameChangeScreen.routeName) {
      User user = settings.arguments;
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
      FixtureRoutArgsForDetail fixture = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AdminFixtureDetail(
            fixture: fixture,
          ));
    }

    if (settings.name == AdminResultDetail.routeName) {
      ResultRoutArgsForDetail result = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AdminResultDetail(
            result: result,
          ));
    }

    if (settings.name == UserFixtureDetail.routeName) {
      FixtureRoutArgsForDetail fixture = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => UserFixtureDetail(
            fixture: fixture,
          ));
    }
    if (settings.name == UserResultDetail.routeName) {
      ResultRoutArgsForDetail result = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => UserResultDetail(
            result: result,
          ));
    }
    return MaterialPageRoute(builder: (context) => UserHome());
  }
}

class FixtureRoutArgs {
  final Fixture fixture;
  final bool edit;

  FixtureRoutArgs({this.fixture, this.edit});
}

class ResultRoutArgs {
  final Result result;
  final Fixture fixture;
  final bool edit;

  ResultRoutArgs({this.result, this.fixture, this.edit});
}
class FixtureRoutArgsForDetail {
  final Fixture fixture;
  FixtureRoutArgsForDetail({this.fixture});
}

class ResultRoutArgsForDetail {
  final Result result;
  ResultRoutArgsForDetail({this.result});
}

