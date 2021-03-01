import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/role/role_bloc.dart';
import '../blocs/role/role_events.dart';
import '../blocs/role/role_state.dart';
import '../models/model.dart';

class RoleAdd extends StatefulWidget {
  static const routeName = "admin_add_role";

  @override
  RoleAddState createState() {
    return RoleAddState();
  }
}

class RoleAddState extends State<RoleAdd> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final _roleNameFocusNode = FocusNode();

  @override
  void dispose() {
    _roleNameFocusNode.dispose();

    super.dispose();
  }

  final Map<String, dynamic> _roles = {};
  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    if (name == null) {
      return;
    }
    _formKey.currentState.save();

    role = Role(
      name: name,
    );
    BlocProvider.of<RoleBloc>(context, listen: false)
      ..add(PostRoleEvent(role: role));
  }

  Role role = Role();
  String name;
  bool isInit = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopPressed,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Add Role"),
        ),
        body: BlocConsumer<RoleBloc, RoleStates>(
          listener: (_, state) {
            if (state is RolePostingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is RolePostingErrorState) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Error Adding the Role')));
            }
            if (state is RolePostedState) {
              BlocProvider.of<RoleBloc>(context).add(GetRoleEvent());
              Navigator.pop(context);
            }
          },
          builder: (_, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      initialValue: '',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Role Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Role Name'),
                      onSaved: (value) {
                        setState(() {
                          this._roles["name"] = value;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          role = Role(
                            name: _roles["name"],
                          );
                          BlocProvider.of<RoleBloc>(context, listen: false)
                            ..add(PostRoleEvent(role: role));
                          //
                          // Navigator.of(context).pushNamedAndRemoveUntil(
                          //     AdminRoleScreen.routeName, (route) => false);

                        }
                      },
                      label: Text('ADD'),
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _willPopPressed() async {
    BlocProvider.of<RoleBloc>(context).add(GetRoleEvent());

    Navigator.of(context).pop();
    return true;
  }
}
