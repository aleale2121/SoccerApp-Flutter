import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/models/model.dart';
import 'package:soccer_app/screens/admin_add_role_screen.dart';
import 'package:soccer_app/screens/route.dart';
import 'package:soccer_app/widgets/role_comp_admin.dart';
import '../blocs/Role/role.dart';

import 'splash_screen.dart';

class AdminRoleScreen extends StatelessWidget {
  static const String routeName = "admin_Role";
  // final GlobalKey<ScaffoldState> scaffoldKey;

  // AdminRoleScreen({@required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Role List"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed(
            RoleAdd.routeName,
          ),
        ),
        body: BlocConsumer<RoleBloc, RoleStates>(
          listener: (_, state) {
            if (state is RoleDeletedState) {
              BlocProvider.of<RoleBloc>(context, listen: false)
                  .add(GetRoleEvent());
            }
          },
          builder: (_, state) {
            print(state.toString());
            if (state is RoleFetchingState) {
              return SplashScreen(title: 'Fetching Role');
            } else if (state is RoleFetchedState) {
              final roles = state.roles;

              return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: roles.length,
                  itemBuilder: (_, idx) => RoleComponent(role: roles[idx]));
            } else if (state is RoleEmptyState) {
              return SplashScreen(title: 'No Role Added');
            } else {
              return SplashScreen(title: 'Failed to load Role');
            }
          },
        ));
  }
}
