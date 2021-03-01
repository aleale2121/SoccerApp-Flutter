import 'package:flutter/material.dart';
import '../widgets/app_drawer_admin.dart';
import 'admin_fixtures_screen.dart';
import 'admin_results_screen.dart';
import 'admin_add_schedule.dart';
import 'route.dart';

class AdminHome extends StatefulWidget {
  static const routeName = 'admin_home';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TabController controller;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('FootBall'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  FixtureAddUpdate.routeName,
                  arguments: FixtureRoutArgs(edit: false),
                );
              })
        ],
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
      ),
      drawer: AppDrawer(),
      body: TabBarView(controller: controller, children: <Widget>[
        AdminFixturesScreen(
          scaffoldKey: scaffoldKey,
        ),
        AdminResultsScreen(
          scaffoldKey: scaffoldKey,
        )
      ]),
    );
  }
}
