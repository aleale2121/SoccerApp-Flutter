import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/fixture/fixture.dart';
import '../models/model.dart';
import '../blocs/result/result.dart';
import 'route.dart';

class ResultAddUpdate extends StatefulWidget {
  static const routeName = "admin_add_result";
  final ResultRoutArgs resultArgs;
  ResultAddUpdate({this.resultArgs});
  @override
  ResultAddUpdateState createState() {
    return ResultAddUpdateState();
  }
}

class ResultAddUpdateState extends State<ResultAddUpdate> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _firstClubResultFocusNode = FocusNode();
  final _secondClubResultFocusNode = FocusNode();

  int firstClubScore = 0;
  int secondClubScore = 0;
  Result result = Result();
  bool isInit = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit && widget.resultArgs.edit) {
      firstClubScore = widget.resultArgs.result.firstClubScore;
      secondClubScore = widget.resultArgs.result.secondClubScore;
      isInit = true;
    }
  }

  @override
  void dispose() {
    _firstClubResultFocusNode.dispose();
    _secondClubResultFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState.save();

    if (widget.resultArgs.edit) {
      result = Result(
        id: widget.resultArgs.result.id,
        firstClubScore: firstClubScore,
        secondClubScore: secondClubScore,
        fixture: widget.resultArgs.result.fixture,
        fixtureId: widget.resultArgs.result.fixture.id,
      );

      BlocProvider.of<ResultsBloc>(context, listen: false)
        ..add(UpdateResultEvent(result: result));
    } else {
      result = Result(
        firstClubScore: firstClubScore,
        secondClubScore: secondClubScore,
        fixture: widget.resultArgs.fixture,
        fixtureId: widget.resultArgs.fixture.id,
      );

      BlocProvider.of<ResultsBloc>(context, listen: false)
        ..add(PostResultEvent(result: result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title:
            widget.resultArgs.edit ? Text("Update Result") : Text("Add Result"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: _saveForm)
        ],
      ),
      body: BlocConsumer<ResultsBloc, ResultStates>(
        listener: (_, state) {
          if ((state is ResultPostingState) || (state is ResultUpdatingState)) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ResultPostingErrorState) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Error Adding the result')));
          }
          if (state is ResultUpdatingState) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Error Updating the result')));
          }
          if ((state is ResultPostedState) || (state is ResultUpdatedState)) {
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                      initialValue: widget.resultArgs.edit
                          ? widget.resultArgs.result.firstClubScore.toString()
                          : firstClubScore.toString(),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      focusNode: _firstClubResultFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_firstClubResultFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'invalid input';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        firstClubScore = int.parse(value);
                      },
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: widget.resultArgs.edit
                              ? widget.resultArgs.result.fixture.clubs[0].name
                              : widget.resultArgs.fixture.clubs[0].name,
                          hintText: 'Enter Score'),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextFormField(
                      initialValue: widget.resultArgs.edit
                          ? widget.resultArgs.result.secondClubScore.toString()
                          : secondClubScore.toString(),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      autofocus: false,
                      focusNode: _secondClubResultFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_secondClubResultFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'value cannot input';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        secondClubScore = int.parse(value);
                      },
                      decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: widget.resultArgs.edit
                              ? widget.resultArgs.result.fixture.clubs[1].name
                              : widget.resultArgs.fixture.clubs[1].name,
                          hintText: 'Enter Score'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
