import 'package:equatable/equatable.dart';

import '../../models/fixture.dart';

abstract class FixtureStates extends Equatable {
  const FixtureStates();
  @override
  List<Object> get props => [];
}

class FixtureUninitializedState extends FixtureStates {}

class FixturesFetchingState extends FixtureStates {}

class FixturesFetchedState extends FixtureStates {
  final List<Fixture> fixtures;
  FixturesFetchedState({required this.fixtures});

  @override
  List<Object> get props => [fixtures];
}

class FixturesFetchingErrorState extends FixtureStates {
  final String message;

  FixturesFetchingErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class FixtureDeletingState extends FixtureStates {}

class FixtureDeletedState extends FixtureStates {}

class FixturesDeletingErrorState extends FixtureStates {
  final String message;

  FixturesDeletingErrorState({required this.message});
  @override
  List<Object> get props => [];
}

class FixturePostingState extends FixtureStates {}

class FixturePostedState extends FixtureStates {}

class FixturePostingErrorState extends FixtureStates {
  final String message;

  FixturePostingErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class FixtureUpdatingState extends FixtureStates {}

class FixtureUpdatedState extends FixtureStates {}

class FixtureUpdatingErrorState extends FixtureStates {
  final String message;
  FixtureUpdatingErrorState({required this.message});
  @override
  List<Object> get props => [];
}

class FixturesEmptyState extends FixtureStates {}
