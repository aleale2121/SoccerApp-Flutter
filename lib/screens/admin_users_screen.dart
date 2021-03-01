import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user.dart';
import '../screens/admin_add_role_screen.dart';
import '../widgets/user_comp_admin.dart';
import '../widgets/app_drawer_admin.dart';
import 'splash_screen.dart';

class AdminUsersScreen extends StatelessWidget {
  static const String routeName = "admin_users_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Users"),
        ),
        drawer: AppDrawer(),
        body: BlocConsumer<UserBloc, UserStates>(
          listener: (_, state) {
            if (state is UserDeletedState) {
              BlocProvider.of<UserBloc>(context, listen: false)
                  .add(GetUsersEvent());
            }
          },
          builder: (_, state) {
            if (state is UsersFetchingState) {
              return SplashScreen(title: 'Fetching Users');
            } else if (state is UsersFetchedState) {
              final users = state.users;

              return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: users.length,
                  itemBuilder: (_, idx) => UserComponent(
                        user: users[idx],
                      ));
            } else if (state is UsersEmptyState) {
              return SplashScreen(title: 'No User Added');
            } else {
              return SplashScreen(title: 'Failed to load User');
            }
          },
        ));
  }
}
