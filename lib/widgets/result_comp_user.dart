import 'package:flutter/material.dart';
import 'package:soccer_app/view/view_result_detail_screen/user_result_detail_screen.dart';
import 'package:soccer_app/route/route.dart';
import '../models/model.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class ResultComponent extends StatelessWidget {
  final Result result;

  ResultComponent({required this.result});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          UserResultDetail.routeName,
          arguments:ResultRoutArgsForDetail(result: result),
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
                            backgroundColor: _randomColor.randomColor(),
                            radius: 25,
                            child: Text(
                              result.fixture!.firstClub[0].toUpperCase(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            child: Text(result.fixture!.matchDate.toString()),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: _randomColor.randomColor(),
                            radius: 25,
                            child: Text(
                              result.fixture!.secondClub[1].toUpperCase(),
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
                            child: Text(result.fixture!.secondClub[1]),
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
      ),
    );
  }
}
