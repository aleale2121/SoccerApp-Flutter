import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../models/fixture.dart';

abstract class FixtureEvents extends Equatable {}

class GetFixturesEvent extends FixtureEvents {
  GetFixturesEvent();
  @override
  List<Object> get props => [];
}

class PostFixtureEvent extends FixtureEvents {
  final Fixture fixture;
  PostFixtureEvent({@required this.fixture});
  @override
  List<Object> get props => [];
}

class UpdateFixtureEvent extends FixtureEvents {
  final Fixture fixture;
  UpdateFixtureEvent({@required this.fixture});
  @override
  List<Object> get props => [];
}

class DeleteFixtureEvent extends FixtureEvents {
  final String fixtureId;
  DeleteFixtureEvent({@required this.fixtureId});

  @override
  List<Object> get props => [];
}
