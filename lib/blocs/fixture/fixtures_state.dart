import 'package:flutter/foundation.dart';
import '../../models/fixture.dart';

abstract class FixtureStates {}

class FixtureUninitializedState extends FixtureStates {}

class FixturesFetchingState extends FixtureStates {}

class FixturesFetchedState extends FixtureStates {
  final List<Fixture> fixtures;
  FixturesFetchedState({@required this.fixtures});
}

class FixturesFetchingErrorState extends FixtureStates {
  final String message;

  FixturesFetchingErrorState({this.message});
}

class FixtureDeletingState extends FixtureStates {}

class FixtureDeletedState extends FixtureStates {}

class FixturesDeletingErrorState extends FixtureStates {
  final String message;

  FixturesDeletingErrorState({this.message});
}

class FixturePostingState extends FixtureStates {}

class FixturePostedState extends FixtureStates {}

class FixturePostingErrorState extends FixtureStates {
  final String message;

  FixturePostingErrorState({this.message});
}

class FixtureUpdatingState extends FixtureStates {}

class FixtureUpdatedState extends FixtureStates {}

class FixtureUpdatingErrorState extends FixtureStates {
  final String message;
  FixtureUpdatingErrorState({this.message});
}

class FixturesEmptyState extends FixtureStates {}
