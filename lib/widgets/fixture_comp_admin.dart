import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/blocs/fixture/fixtures_bloc.dart';
import 'package:soccer_app/blocs/fixture/fixtures_event.dart';
import 'package:soccer_app/blocs/result/results_bloc.dart';
import 'package:soccer_app/screens/admin_add_schedule.dart';
import 'package:soccer_app/screens/detailScreens/admin_fixture_detail_screen.dart';
import '../screens/admin_add_result.dart';
import '../screens/route.dart';
import '../models/model.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class FixtureComponentAdmin extends StatelessWidget {
  final Fixture fixture;

  FixtureComponentAdmin({
    @required this.fixture,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AdminFixtureDetail.routeName,
          arguments:          FixtureRoutArgsForDetail(fixture: fixture),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: _randomColor.randomColor(),
                                  radius: 25,
                                  child: Text(
                                    fixture.clubs[0].name[0].toUpperCase(),
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
                                  child: Text(fixture.clubs[0].name),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Text(fixture.startingDate.toString()),
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
                                CircleAvatar(
                                  backgroundColor: _randomColor.randomColor(),
                                  radius: 25,
                                  child: Text(
                                    fixture.clubs[1].name[0].toUpperCase(),
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
                                  child: Text(fixture.clubs[1].name),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           Navigator.of(context).pushNamed(
                //             ResultAddUpdate.routeName,
                //             arguments:
                //                 ResultRoutArgs(fixture: fixture, edit: true),
                //           );
                //         },
                //         child: Container(
                //           child: Text('ADD RESULT'),
                //         ),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           Navigator.of(context).pushNamed(
                //             FixtureAddUpdate.routeName,
                //             arguments:
                //             FixtureRoutArgs(fixture: fixture, edit: true),
                //           );
                //         },
                //         child: Column(
                //           children: [
                //             Icon(Icons.update),
                //             Text(
                //               "UPDATE",
                //               style: TextStyle(
                //                 decoration: TextDecoration.underline,
                //                 fontWeight: FontWeight.bold,
                //                 fontStyle: FontStyle.italic,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           BlocProvider.of<FixturesBloc>(context).add(
                //               DeleteFixtureEvent(
                //                   fixtureId: fixture.id.toString()));
                //         },
                //         child: Column(
                //           children: [
                //             Icon(
                //               Icons.delete_rounded,
                //               color: Colors.red,
                //             ),
                //             Text(
                //               "DELETE",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontStyle: FontStyle.italic,
                //                 decoration: TextDecoration.underline,
                //                 color: Colors.blue,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       // InkWell(
                //       //   onTap: () {},
                //       //   child: Column(
                //       //     children: [
                //       //       Icon(Icons.read_more),
                //       //       Text(
                //       //         "READ",
                //       //         style: TextStyle(
                //       //           decoration: TextDecoration.underline,
                //       //           fontWeight: FontWeight.bold,
                //       //           fontStyle: FontStyle.italic,
                //       //           color: Colors.blue,
                //       //         ),
                //       //       ),
                //       //     ],
                //       //   ),
                //       // )
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        child: Column(
                          children: [
                            Icon(Icons.update),
                            Text(
                              "UPDATE",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<FixturesBloc>(context).add(
                              DeleteFixtureEvent(
                                  fixtureId: fixture.id.toString()));
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.delete_rounded,
                              color: Colors.red,
                            ),
                            Text(
                              "DELETE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
                            ),
                          ],
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
                        child: Column(
                          children: [
                            Icon(Icons.add),
                            Text(
                              "Add",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
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
