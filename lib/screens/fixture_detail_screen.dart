import 'package:flutter/material.dart';
import '../models/model.dart';

class FixtureComponent extends StatelessWidget {
  final Result result;

  FixtureComponent({@required this.result});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Card(
          elevation: 10,
          color: Colors.white30,
          shadowColor: Colors.black54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          radius: 50,
                          child: Text(
                            result.fixture.clubs[0].name
                                .substring(0)
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(result.fixture.clubs[0].name),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 50,
                          child: ListView(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(result.firstClubScore.toString()),
                            Text(result.secondClubScore.toString())
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(result.fixture.startingDate.toString()),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          radius: 50,
                          child: Text(
                            result.fixture.clubs[0].name
                                .substring(0)
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(result.fixture.clubs[0].name),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
