import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/auth/auth_blocs.dart';
import 'package:soccer_app/blocs/auth/auth_events.dart';
import '../models/model.dart';
import '../blocs/user/user.dart';

class PasswordChangeScreen extends StatefulWidget {
  static const routeName = "password_change_screen";
  final User user;
  PasswordChangeScreen({@required this.user});
  @override
  PasswordChangeScreenState createState() {
    return PasswordChangeScreenState();
  }
}

class PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _oldPasswordFocusNode = FocusNode();
  final _confirmedPassFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();

  String oldPassword = '';
  String newPassword = '';
  String confirmedPassword = '';

  @override
  void dispose() {
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmedPassFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    print(widget.user.fullName);
    print(widget.user.password);
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    print('valid');
    _formKey.currentState.save();
    User userUpdated = widget.user;
    userUpdated.password = newPassword;
    BlocProvider.of<UserBloc>(context, listen: false)
      ..add(
          UpdateUserPasswordEvent(user: userUpdated, oldPassword: oldPassword));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit Account"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: _saveForm)
        ],
      ),
      body: BlocConsumer<UserBloc, UserStates>(
        listener: (_, state) {
          if (state is UserUpdatingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is UserUpdatingErrorState) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Error changing password')));
          }
          if (state is UserIncorrectOldPasswordState) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Your old password is incorrect')));
          }
          if (state is UserUpdatedState) {
            BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
            Navigator.of(context).pushReplacementNamed('/');
          }
        },
        builder: (_, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      focusNode: _oldPasswordFocusNode,
                      obscureText: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_oldPasswordFocusNode);
                      },
                      validator: (value) {
                        if (value.length < 6) {
                          return 'incorrect password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        oldPassword = value;
                      },
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Old password',
                          hintText: 'Enter old password'),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      focusNode: _newPasswordFocusNode,
                      obscureText: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_newPasswordFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'invalid input';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newPassword = value;
                      },
                      onChanged: (value) {
                        newPassword = value;
                      },
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New password',
                          hintText: 'Enter new password'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      focusNode: _confirmedPassFocusNode,
                      obscureText: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_confirmedPassFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'invalid input';
                        }
                        if (value != newPassword) {
                          return 'password not match';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmedPassword = value;
                      },
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirmed password',
                          hintText: 'Enter confirmed password'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
