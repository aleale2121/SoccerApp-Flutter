import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/Role/role.dart';
import '../screens/admin_manage_user_role_screen.dart';
import '../models/user.dart';

class UserComponent extends StatelessWidget {
  final User user;

  UserComponent({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.fullName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(user.email),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
        subtitle: Text(user.role.name),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            //BlocProvider.of<RoleBloc>(context).add(GetRoleEvent());
            Navigator.of(context).pushNamed(
              AdminEditUserRole.routeName,
              arguments: user,
            );
          },
        ),
      ),
    );
  }
}
