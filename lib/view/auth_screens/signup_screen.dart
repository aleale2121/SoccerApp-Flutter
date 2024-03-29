import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth.dart';
import '../../models/user.dart';
import 'login_screen.dart';
import '../home_screen/user_home_screen.dart';
import '../../widgets/rounded_button.dart';

import '../../constants.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'sign_up_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String fullName;
  late String email;
  late String phone;
  late String password;
  String role = 'user';

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
                                ),
                              ),
                            )
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
                        padding: 16.0,
                        radius: 30.0,
                        elevation: 5.0,
                        width: 200.0,
                        height: 40.0,
                        title: 'Sign Up',
                        colour: Colors.lightBlueAccent,
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (!form!.validate()) {
                            return;
                          }
                          UsersInfo user = new UsersInfo(
                            displayName: fullName,
                            email: email,
                            phone: phone,
                            password: password,
                            role: role,
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
