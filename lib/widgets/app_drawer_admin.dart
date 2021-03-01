import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user.dart';
import '../screens/admin_users_screen.dart';
import '../blocs/auth/auth.dart';
import '../screens/admin_role_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Soccer'),
              automaticallyImplyLeading: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50.0,
                child: Image.asset(
                  "images/person.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.sports_soccer),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Role'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AdminRoleScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Users'),
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
                Navigator.of(context)
                    .pushReplacementNamed(AdminUsersScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
