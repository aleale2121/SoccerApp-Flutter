import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/fixture/fixtures_bloc.dart';
import 'package:soccer_app/blocs/fixture/fixtures_event.dart';
import 'package:soccer_app/view/edit_fixture_screen/admin_add_schedule.dart';
import 'package:soccer_app/view/shared/circular_image.dart';
import 'package:soccer_app/view/view_fixture_detail_screen/admin_fixture_detail_screen.dart';
import '../view/edit_result_screen/admin_add_result.dart';
import '../route/route.dart';
import '../models/model.dart';
class FixtureComponentAdmin extends StatelessWidget {
  final Fixture fixture;

  FixtureComponentAdmin({
    required this.fixture,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AdminFixtureDetail.routeName,
          arguments: FixtureRoutArgsForDetail(fixture: fixture),
        );
      },
      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 15,
          color: Colors.white,
          shadowColor: Colors.black54,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularImage(
                                  placeholderText:
                                      fixture.firstClub[0].toUpperCase(),
                                  radius: 25,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Text(fixture.matchDate.toString()),
                                    ),
                                  ],
                                ),
                               CircularImage(
                                  placeholderText: fixture.secondClub[0].toUpperCase(),
                                  radius: 25,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    fixture.firstClub.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    fixture.stadiumName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    fixture.secondClub.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            FixtureAddUpdate.routeName,
                            arguments:
                                FixtureRoutArgs(fixture: fixture, edit: true),
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<FixturesBloc>(context).add(
                              DeleteFixture(fixtureId: fixture.id.toString()));
                        },
                        child: Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ResultAddUpdate.routeName,
                            arguments:
                                ResultRoutArgs(fixture: fixture, edit: false),
                          );
                        },
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
