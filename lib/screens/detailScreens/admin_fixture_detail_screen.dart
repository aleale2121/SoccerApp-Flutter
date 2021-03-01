import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/fixture/fixture.dart';
import 'package:soccer_app/blocs/fixture/fixtures_bloc.dart';
import 'package:soccer_app/models/fixture.dart';
import 'package:soccer_app/screens/route.dart';


class AdminFixtureDetail extends StatelessWidget {
  static const routeName = 'courseDetail';
  final FixtureRoutArgsForDetail fixture;

  AdminFixtureDetail({@required this.fixture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.fixture.fixture.clubs[0].name}' + "Vs" + '${this.fixture.fixture.clubs[1].name}' ),

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


              Text('Stadium: ${this.fixture.fixture.stadiumName}'),
              Text(
                "--------------------------------------------",
                style: TextStyle(color: Colors.redAccent),
              ),
              SizedBox(
                height: 10,
              ),
                Text('StartingDate: ${this.fixture.fixture.startingDate}'),
              Text(
                "--------------------------------------------",
                style: TextStyle(color: Colors.redAccent),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Latitude: ${this.fixture.fixture.stadiumLatitude}'),
              Text(
                "--------------------------------------------",
                style: TextStyle(color: Colors.redAccent),
              ),
              SizedBox(
                height: 10,
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
