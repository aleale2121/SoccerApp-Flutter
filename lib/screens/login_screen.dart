import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/rounded_button.dart';
import '../constants.dart';
import '../blocs/auth/auth.dart';
import '../models/user.dart';
import 'admin_home_screen.dart';
import 'user_home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String email;

  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
                key: _formKey,
                child: BlocConsumer<AuthBloc, AuthStates>(
                  listener: (_, state) {
                    if (state is LoginSuccessState) {
                      if (state.user.role.name.toUpperCase() == 'ADMIN') {
                        Navigator.of(context)
                            .pushReplacementNamed(AdminHome.routeName);
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed(UserHome.routeName);
                      }
                    }
                  },
                  builder: (_, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Flexible(
                          child: (state is LoggingState)
                              ? SizedBox(

                            child: LinearProgressIndicator(
                              valueColor:AlwaysStoppedAnimation<Color>(Colors.redAccent),
                            ),
                            height:10.0,
                            width: 50.0,

                          )
                              : Container(
                                  height: 200.0,
                                  child: Image.asset('images/logo.png')),
                        ),
                        (state is LoginFailedState)
                            ? Container(
                                child: Center(
                                    child: Text(
                                'Failed to Authenticate',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))
                            : SizedBox(
                                height: 1,
                              ),
                        (state is IncorrectUsernameOrPasswordState)
                            ? Container(
                                child: Center(
                                    child: Text(
                                'Incorrect username or password',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))
                            : SizedBox(
                                height: 1,
                              ),
                        SizedBox(
                          height: 48.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email',
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        RoundedButton(
                          title: 'Log In',
                          colour: Colors.lightBlueAccent,
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (!form.validate()) {
                              return;
                            }
                            User user =
                                new User(email: email, password: password);
                            LoginEvent loginEvent = new LoginEvent(user: user);
                            BlocProvider.of<AuthBloc>(context).add(loginEvent);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, SignUpScreen.routeName);
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ))));
  }
}
