import 'package:flutter/material.dart';
import 'package:soccer_app/view/shared/circular_image.dart';
import 'package:soccer_app/view/view_fixture_detail_screen/user_fixture_detail_screen.dart';
import 'package:soccer_app/route/route.dart';
import '../models/model.dart';

class FixtureComponent extends StatelessWidget {
  final Fixture fixture;

  FixtureComponent({required this.fixture});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          UserFixtureDetail.routeName,
          arguments: FixtureRoutArgsForDetail(fixture: fixture),
        );
      },
      child: Card(
        elevation: 5,
        color: Colors.white,
        shadowColor: Colors.black45,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircularImage(
                          placeholderText: fixture.firstClub[0].toUpperCase(),
                          radius: 25,
                          imageUrl: fixture.clubA?.logoUrl,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(fixture.firstClub),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(fixture.matchDate.toString()),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(fixture.stadiumName),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircularImage(
                          placeholderText: fixture.secondClub[0].toUpperCase(),
                          radius: 25,
                          imageUrl: fixture.clubB?.logoUrl,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(fixture.secondClub),
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
