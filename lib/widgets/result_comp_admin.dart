import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/screens/view_result_detail_screen/admin_result_detail_screen.dart';
import '../blocs/result/result.dart';
import '../screens/edit_result_screen/admin_add_result.dart';
import '../route/route.dart';
import '../models/model.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class ResultComponentAdmin extends StatelessWidget {
  final Result result;

  ResultComponentAdmin({
    required this.result,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AdminResultDetail.routeName,
          arguments: ResultRoutArgsForDetail(result: result),
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
                                    result.fixture!.firstClub[0]
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
                                  child: Text(result.fixture!.firstClub),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      result.firstClubScore.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 40,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      result.secondClubScore.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                      result.fixture!.matchDate.toString()),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: _randomColor.randomColor(),
                                  radius: 25,
                                  child: Text(
                                    result.fixture!.secondClub[0]
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
                                  child: Text(result.fixture!.secondClub),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ResultAddUpdate.routeName,
                            arguments:
                                ResultRoutArgs(result: result, edit: true),
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
                          BlocProvider.of<ResultsBloc>(context).add(
                              DeleteResult(
                                  resultId: result.id.toString()));
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
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.read_more),
                            Text(
                              "READ",
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
