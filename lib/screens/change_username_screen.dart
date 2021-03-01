import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/auth/auth_blocs.dart';
import 'package:soccer_app/blocs/auth/auth_events.dart';
import '../models/model.dart';
import '../blocs/user/user.dart';

class UsernameChangeScreen extends StatefulWidget {
  static const routeName = "username_change_screen";
  final User user;
  UsernameChangeScreen({this.user});
  @override
  UsernameChangeScreenState createState() {
    return UsernameChangeScreenState();
  }
}

class UsernameChangeScreenState extends State<UsernameChangeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _oldUsernameFocusNode = FocusNode();
  final _newUsernameFocusNode = FocusNode();
  final _confirmedUsernameFocusNode = FocusNode();

  String oldUsername = '';
  String newUsername = '';
  String confirmedUsername = '';

  @override
  void dispose() {
    _oldUsernameFocusNode.dispose();
    _newUsernameFocusNode.dispose();
    _confirmedUsernameFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    print(widget.user.toString());
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    User userUpdated = widget.user;
    userUpdated.email = newUsername;

    BlocProvider.of<UserBloc>(context, listen: false)
      ..add(UpdateUserEvent(user: userUpdated));
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
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      focusNode: _oldUsernameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_oldUsernameFocusNode);
                      },
                      validator: (value) {
                        if (value != widget.user.email) {
                          return 'incorrect email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        oldUsername = value;
                      },
                      onChanged: (value) {
                        newUsername = value;
                      },
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Old email',
                          hintText: 'Enter old email'),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      focusNode: _newUsernameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_newUsernameFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'invalid input';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newUsername = value;
                      },
                      onChanged: (value) {
                        newUsername = value;
                      },
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New email',
                          hintText: 'Enter new email'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      focusNode: _confirmedUsernameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_confirmedUsernameFocusNode);
                      },
                      onChanged: (value) {
                        confirmedUsername = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'invalid input';
                        }
                        if (value != newUsername) {
                          //print(value);
                          print(newUsername);
                          return 'email not match';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmedUsername = value;
                      },
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirmed email',
                        hintText: 'Enter confirmed email',
                      ),
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
