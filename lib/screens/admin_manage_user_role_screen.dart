import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/role/role.dart';
import 'package:soccer_app/blocs/user/user.dart';
import '../blocs/role/role_bloc.dart';
import '../blocs/role/role_state.dart';
import '../models/model.dart';
import '../blocs/club/club.dart';

class AdminEditUserRole extends StatefulWidget {
  static const routeName = "admin_edit_user_role";
  final User user;

  AdminEditUserRole({@override this.user});

  @override
  AdminEditUserRoleState createState() {
    return AdminEditUserRoleState();
  }
}

class AdminEditUserRoleState extends State<AdminEditUserRole> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> roleNames = [];
  Map<String, Role> roles = {};
  String newRole = '';
  bool isInit = false;

  Future<void> _save() async {
    print(newRole);
    if (newRole != widget.user.role.name) {
      User userUpdated = new User.fullInfo(
        id: widget.user.id,
        password: widget.user.password,
        email: widget.user.email,
        role: roles[newRole],
        roleId: roles[newRole].id,
        fullName: widget.user.fullName,
        phone: widget.user.phone,
      );
      BlocProvider.of<UserBloc>(context, listen: false)
        ..add(UpdateUserEvent(user: userUpdated));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopPressed,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Edit User Role"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: _save)
          ],
        ),
        body: BlocConsumer<UserBloc, UserStates>(
          listener: (context, state) {
            if (state is UserUpdatingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is UserUpdatingErrorState) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Error Editing the role')));
            }
            if (state is UserUpdatedState) {
              BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  Container(
                    child: BlocBuilder<RoleBloc, RoleStates>(
                      builder: (context, state) {
                        if (state is RoleFetchingState) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ClubsEmptyState) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('No role found !!!'),
                          );
                        }
                        if (state is ClubsFetchingErrorState) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Error Fetching Roles !!!'),
                          );
                        }
                        if (state is RoleFetchedState) {
                          if (isInit == false) {
                            newRole = widget.user.role.name;
                            roleNames.clear();
                            state.roles.forEach((element) {
                              roles[element.name] = element;
                              roleNames.add(element.name);
                            });
                            isInit = true;
                          }
                        }
                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: roleNames.length == 1
                                ? Text('not other role ')
                                : DropdownButton<String>(
                                    autofocus: true,
                                    elevation: 15,
                                    value: newRole,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        newRole = newValue;
                                      });
                                    },
                                    items: roleNames
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        Text(widget.user.fullName),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(widget.user.email),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(widget.user.role.name),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _willPopPressed() async {
    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
    Navigator.of(context).pop();
    return true;
  }
}
