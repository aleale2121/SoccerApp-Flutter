import 'package:flutter/material.dart';
import 'package:soccer_app/screens/route.dart';

class AdminResultDetail extends StatelessWidget {
  static const routeName = 'admin_result_detail';
  final ResultRoutArgsForDetail result;

  AdminResultDetail({@required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.result.result.fixture.clubs[0].name}' + "   Vs  " + '${this.result.result.fixture.clubs[1].name}' ),

      ),
      body:
      Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "--------------------------------------------",
              style: TextStyle(color: Colors.redAccent),
            ),
            Text('${this.result.result.fixture.clubs[0].name}'+" Score:  " + '${this.result.result.firstClubScore}'),
            SizedBox(
              height: 10,
            ),
            Text(
              "--------------------------------------------",
              style: TextStyle(color: Colors.redAccent),
            ),
            Text('${this.result.result.fixture.clubs[1].name}'+" Score:  " + ' ${this.result.result.secondClubScore}'),
            SizedBox(
              height: 30,
            ),
            Text(
              "--------------------------------------------",
              style: TextStyle(color: Colors.redAccent),
            ),
            Text('Scorers ${this.result.result.scorers}'),
            // Text('Longtude: ${this.fixture.fixture.stadiumLongitude}'),

            Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("--------------------------------------------"),
          ],
        ),
      ),

    );
  }
}
