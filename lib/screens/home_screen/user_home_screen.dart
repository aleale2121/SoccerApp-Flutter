import 'package:flutter/material.dart';
import 'package:soccer_app/models/model.dart';
import 'package:soccer_app/screens/auth_screens/change_password_screen.dart';
import 'package:soccer_app/screens/auth_screens/change_username_screen.dart';
import 'package:soccer_app/screens/auth_screens/user_delete_account.dart';
import 'package:soccer_app/util/util.dart';
import 'package:soccer_app/widgets/app_drawer_user.dart';
import '../fixtures_screen/user_fixtures_screen.dart';
import '../results_screen/user_results_screen.dart';

class UserHome extends StatefulWidget {
  static const routeName = 'user_home';

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final Util util = Util();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(
              text: "Fixtures",
            ),
            Tab(
              text: "Result",
            )
          ],
        ),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: TextButton(
                        child: Text('Change Password'),
                        onPressed: () async {
                          UsersInfo? user = await util.getUserInformation();
                          if (user != null) {
                            Navigator.of(context).pushNamed(
                                PasswordChangeScreen.routeName,
                                arguments: user);
                          }
                        },
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        child: Text('Change Username'),
                        onPressed: () async {
                          Util util = new Util();
                          UsersInfo? user = await util.getUserInformation();
                          if (user != null) {
                            Navigator.of(context).pushNamed(
                                UsernameChangeScreen.routeName,
                                arguments: user);
                          }
                        },
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        child: Text('Delete Account'),
                        onPressed: () async {
                          Navigator.of(context).pushNamed(
                            DeleteAccountPage.routeName,
                          );
                        },
                      ),
                      value: 3,
                    ),
                  ])
        ],
      ),
      drawer: UserAppDrawer(),
      body: TabBarView(
          controller: controller,
          children: <Widget>[UserFixturesScreen(), UserResultsScreen()]),
    );
  }
}
