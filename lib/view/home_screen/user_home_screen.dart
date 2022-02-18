import 'package:flutter/material.dart';

import 'package:soccer_app/models/model.dart';
import 'package:soccer_app/util/util.dart';
import 'package:soccer_app/view/auth_screens/change_password_screen.dart';
import 'package:soccer_app/view/auth_screens/change_username_screen.dart';
import 'package:soccer_app/view/auth_screens/user_delete_account.dart';
import 'package:soccer_app/view/home_screen/widgets/outline_indicator.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        iconTheme: IconThemeData(
          color: Colors.indigo[900],
          size: 30,
        ), //add this line here
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Header(),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Material(
                  color: Colors.white,
                  elevation: 5.0,
                  child: Container(
                    height: 600,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        TabsList(controller: controller),
                        Container(
                          height: 400,
                          child: TabBarView(
                            controller: controller,
                            children: [
                              UserFixturesScreen(),
                              UserResultsScreen(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabsList extends StatelessWidget {
  const TabsList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: OutlineIndicator(
          color: Colors.blue.shade100,
          radius: Radius.circular(5),
          strokeWidth: 2.5,
        ),
        tabs: [
          Tab(
            child: CustomTabBar(
              displayText: "MATCHES",
            ),
          ),
          Tab(
            child: CustomTabBar(
              displayText: "RESULTS",
            ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Material(
        elevation: 5.0,
        color: Colors.white,
        child: Container(
          alignment: Alignment.topLeft,
          height: 100,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/betking.jpeg"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Ethiopia\nPremier League",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final String displayText;
  const CustomTabBar({
    Key? key,
    required this.displayText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          displayText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
