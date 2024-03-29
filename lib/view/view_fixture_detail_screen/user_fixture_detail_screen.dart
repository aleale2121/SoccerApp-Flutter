import 'package:flutter/material.dart';
import 'package:soccer_app/route/route.dart';

class UserFixtureDetail extends StatelessWidget {
  static const routeName = 'user_detail_screen';
  final FixtureRoutArgsForDetail fixture;

  UserFixtureDetail({required this.fixture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.fixture.fixture.firstClub}' +
            "Vs" +
            '${this.fixture.fixture.secondClub}'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "--------------------------------------------",
              style: TextStyle(color: Colors.redAccent),
            ),
            Text('Stadium: ${this.fixture.fixture.stadiumName}'),
            SizedBox(
              height: 10,
            ),
            Text(
              "--------------------------------------------",
              style: TextStyle(color: Colors.redAccent),
            ),
            Text('StartingDate: ${this.fixture.fixture.matchDate}'),
            SizedBox(
              height: 10,
            ),
            Text(
              "--------------------------------------------",
              style: TextStyle(color: Colors.redAccent),
            ),
            Text('Latitude: ${this.fixture.fixture.stadiumLatitude}'),
            SizedBox(
              height: 10,
            ),
            Text(
              "--------------------------------------------",
              style: TextStyle(color: Colors.redAccent),
            ),
            Text('Longtude: ${this.fixture.fixture.stadiumLongitude}'),
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
            Text("GOOD LUCK"),
          ],
        ),
      ),
    );
  }
}
