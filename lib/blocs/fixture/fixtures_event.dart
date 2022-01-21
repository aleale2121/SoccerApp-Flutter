import 'package:equatable/equatable.dart';
import '../../models/fixture.dart';

abstract class FixtureEvents extends Equatable {
  const FixtureEvents();
  @override
  List<Object> get props => [];
}

class LoadFixtures extends FixtureEvents {}

class AddFixture extends FixtureEvents {
  final Fixture fixture;
  AddFixture({required this.fixture});
  @override
  List<Object> get props => [fixture];
}

class UpdateFixture extends FixtureEvents {
  final Fixture fixture;
  UpdateFixture({required this.fixture});
  @override
  List<Object> get props => [fixture];
}

class DeleteFixture extends FixtureEvents {
  final String fixtureId;
  DeleteFixture({required this.fixtureId});

  @override
  List<Object> get props => [fixtureId];
}

class FixturesUpdated extends FixtureEvents {
  final List<Fixture> fixtures;
  const FixturesUpdated({
    required this.fixtures,
  });
  @override
  List<Object> get props => [fixtures];
}
