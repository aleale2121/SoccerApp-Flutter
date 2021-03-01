import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth.dart';
import '../models/user.dart';
import 'login_screen.dart';
import 'user_home_screen.dart';
import '../widgets/rounded_button.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'sign_up_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName;
  String email;
  String phone;
  String password;
  int roleId = 1;

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: BlocConsumer<AuthBloc, AuthStates>(
                listener: (_, state) {
                  if (state is SignUpSuccessState) {
                    Navigator.of(context)
                        .pushReplacementNamed(UserHome.routeName);
                  }
                },
                builder: (_, state) {
                  return Column(
                    children: [
                      (state is SignUpFailedState)
                          ? Container(
                              child: Center(
                                  child: Text(
                              'Failed to SignUp',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            )))
                          : SizedBox(
                              height: 1,
                            ),
                      (state is EmailAlreadyExistState)
                          ? Container(
                              child: Center(
                                  child: Text(
                              'Email already exist',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            )))
                          : SizedBox(
                              height: 1,
                            ),
                      (state is PhoneAlreadyExistState)
                          ? Container(
                              child: Center(
                                  child: Text(
                              'Phone already exist',
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
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          fullName = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your full name',
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email',
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your phone',
                        ),
                      ),
                      SizedBox(
                        height: 8,
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
                        height: 8,
                      ),
                      RoundedButton(
                        title: 'Sign Up',
                        colour: Colors.lightBlueAccent,
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (!form.validate()) {
                            return;
                          }
                          User user = new User.fullInfo(
                            fullName: fullName,
                            email: email,
                            phone: phone,
                            password: password,
                            roleId: roleId,
                          );
                          SignUpEvent signUpEvent = new SignUpEvent(user: user);
                          BlocProvider.of<AuthBloc>(context).add(signUpEvent);
                        },
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: Text(
                            'Already Have Account?',
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
