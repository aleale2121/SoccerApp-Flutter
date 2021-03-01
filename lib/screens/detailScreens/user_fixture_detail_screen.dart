import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/fixture/fixture.dart';
import 'package:soccer_app/blocs/fixture/fixtures_bloc.dart';
import 'package:soccer_app/models/fixture.dart';
import 'package:soccer_app/screens/route.dart';

class UserFixtureDetail extends StatelessWidget {
  static const routeName = 'user_detail_screen';
  final FixtureRoutArgsForDetail fixture;

  UserFixtureDetail({@required this.fixture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.fixture.fixture.clubs[0].name}' +
            "Vs" +
            '${this.fixture.fixture.clubs[1].name}'),
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
            Text('StartingDate: ${this.fixture.fixture.startingDate}'),
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
