import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/Role/role.dart';
import '../screens/admin_role_screen.dart';
import '../models/user.dart';

class RoleComponent extends StatelessWidget {
  final Role role;

  RoleComponent({this.role});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(role.name.toString()),
        IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              BlocProvider.of<RoleBloc>(context, listen: false)
                ..add(DeleteRoleEvent(RoleId: role.id.toString()));
              Navigator.of(context).pushNamed(AdminRoleScreen.routeName);
            })
      ],
    ));
  }
}
