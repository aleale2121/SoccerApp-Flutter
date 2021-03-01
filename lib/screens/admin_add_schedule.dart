import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/result/result.dart';
import '../models/model.dart';
import '../blocs/club/club.dart';
import '../blocs/fixture/fixture.dart';
import 'route.dart';

class FixtureAddUpdate extends StatefulWidget {
  static const routeName = "admin_add_schedule";
  final FixtureRoutArgs fixtureArgs;

  FixtureAddUpdate({this.fixtureArgs});

  @override
  FixtureAddUpdateState createState() {
    return FixtureAddUpdateState();
  }
}

class FixtureAddUpdateState extends State<FixtureAddUpdate> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _startingTimeFocusNode = FocusNode();
  final _stadiumNameFocusNode = FocusNode();
  final _latitudeFocusNode = FocusNode();
  final _longitudeFocusNode = FocusNode();

  @override
  void dispose() {
    _startingTimeFocusNode.dispose();
    _stadiumNameFocusNode.dispose();
    _latitudeFocusNode.dispose();
    _longitudeFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    if (firstClubName == null ||
        secondClubName == null ||
        arrivalTime.isEmpty) {
      return;
    }
    _formKey.currentState.save();

    if (widget.fixtureArgs.edit) {
      fixture = Fixture(
          id: widget.fixtureArgs.fixture.id,
          stadiumName: stadiumName,
          stadiumLatitude: lat,
          stadiumLongitude: long,
          startingDate: startingTime,
          clubs: [clubs[firstClubName], clubs[secondClubName]]);

      BlocProvider.of<FixturesBloc>(context, listen: false)
        ..add(UpdateFixtureEvent(fixture: fixture));
    } else {
      fixture = Fixture(
          stadiumName: stadiumName,
          stadiumLatitude: lat,
          stadiumLongitude: long,
          startingDate: startingTime,
          clubs: [clubs[firstClubName], clubs[secondClubName]]);
      BlocProvider.of<FixturesBloc>(context, listen: false)
        ..add(PostFixtureEvent(fixture: fixture));
    }
  }

  String arrivalTime;
  Map<String, Club> clubs = {};
  List<String> clubNames = [];
  Fixture fixture = Fixture();
  String firstClubName;
  String secondClubName;
  String stadiumName;
  double lat;
  double long;
  DateTime startingTime;
  bool isInit = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopPressed,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: widget.fixtureArgs.edit
              ? Text("Update Fixture")
              : Text("Add Fixture"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: _saveForm)
          ],
        ),
        body: BlocConsumer<FixturesBloc, FixtureStates>(
          listener: (_, state) {
            if ((state is FixturePostingState) ||
                (state is FixtureUpdatingState)) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FixturePostingErrorState) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Error Adding the fixture')));
            }
            if (state is FixtureUpdatingErrorState) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Error Updating the fixture')));
            }
            if ((state is FixturePostedState) ||
                (state is FixtureUpdatedState)) {
              BlocProvider.of<FixturesBloc>(context).add(GetFixturesEvent());
              BlocProvider.of<ResultsBloc>(context).add(GetResultsEvent());
              Navigator.pop(context);
            }
          },
          builder: (_, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<ClubsBloc, ClubStates>(
                      builder: (_, state) {
                        if (state is ClubsFetchingState) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ClubsEmptyState) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('No clubs found !!!'),
                          );
                        }
                        if (state is ClubsFetchingState) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Error Fetching Clubs !!!'),
                          );
                        }
                        if (state is ClubFetchedState) {
                          clubNames.clear();
                          state.clubs.forEach((element) {
                            clubs[element.name] = element;
                            clubNames.add(element.name);
                          });
                          if (clubNames.length >= 2) {
                            if (!isInit) {
                              if (!widget.fixtureArgs.edit) {
                                firstClubName = clubNames[0];
                                secondClubName = clubNames[1];
                              } else {
                                firstClubName =
                                    widget.fixtureArgs.fixture.clubs[0].name;
                                secondClubName =
                                    widget.fixtureArgs.fixture.clubs[1].name;
                              }
                              isInit = true;
                            }
                          }
                        }
                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clubNames.length < 2
                                    ? Text('not enough clubs')
                                    : DropdownButton<String>(
                                        autofocus: true,
                                        elevation: 15,
                                        value: firstClubName,
                                        onChanged: (String newValue) {
                                          if (newValue != secondClubName) {
                                            setState(() {
                                              firstClubName = newValue;
                                            });
                                          }
                                        },
                                        items: clubNames
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: clubNames.length < 2
                                    ? Text('not enough clubs')
                                    : DropdownButton<String>(
                                        autofocus: true,
                                        value: secondClubName,
                                        onChanged: (String newValue) {
                                          if (newValue != firstClubName) {
                                            setState(() {
                                              secondClubName = newValue;
                                            });
                                          }
                                        },
                                        items: clubNames
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        dateMask: 'd MMMM, yyyy - hh:mm a',
                        initialValue: null,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_startingTimeFocusNode);
                        },
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: 'Hour',
                        onChanged: (val) {
                          print(DateTime.now().millisecondsSinceEpoch);
                          arrivalTime = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'value cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          startingTime = getDateTimeValue(val);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: TextFormField(
                        initialValue: widget.fixtureArgs.edit
                            ? widget.fixtureArgs.fixture.stadiumName
                            : '',
                        textAlign: TextAlign.left,
                        autofocus: false,
                        focusNode: _stadiumNameFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_stadiumNameFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'invalid input';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          stadiumName = value;
                        },
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Stadium',
                            hintText: 'Enter Stadium Name'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: TextFormField(
                        initialValue: widget.fixtureArgs.edit
                            ? widget.fixtureArgs.fixture.stadiumLatitude
                                .toString()
                            : '',
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        autofocus: false,
                        focusNode: _latitudeFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_latitudeFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'value cannot input';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          lat = double.parse(value);
                        },
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Stadium Latitude',
                            hintText: 'Enter Stadium Latitude'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: TextFormField(
                        initialValue: widget.fixtureArgs.edit
                            ? widget.fixtureArgs.fixture.stadiumLongitude
                                .toString()
                            : '',
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        autofocus: false,
                        focusNode: _longitudeFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'value cannot input';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_longitudeFocusNode);
                        },
                        onSaved: (value) {
                          long = double.parse(value);
                        },
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Stadium Longitude',
                            hintText: 'Enter Stadium Longitude'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _willPopPressed() async {
    BlocProvider.of<FixturesBloc>(context).add(GetFixturesEvent());
    BlocProvider.of<ResultsBloc>(context).add(GetResultsEvent());
    Navigator.of(context).pop();
    return true;
  }

  DateTime getDateTimeValue(String dateTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dat = dateFormat.parse(dateTime);
    return dat;
  }
}
