import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../models/fixture.dart';
import '../../models/http_exception.dart';
import '../../repository/fixture_repository.dart';
import 'fixtures_event.dart';
import 'fixtures_state.dart';

class FixturesBloc extends Bloc<FixtureEvents, FixtureStates> {
  FixtureRepository fixturesRepository;
  FixturesBloc({@required this.fixturesRepository})
      : super(FixtureUninitializedState());

  @override
  Stream<FixtureStates> mapEventToState(FixtureEvents event) async* {
    if (event is GetFixturesEvent) {
      yield* _mapGetFixturesEventToState();
    } else if (event is PostFixtureEvent) {
      print('-------------------------------------vdsfhdfjdf-------');
      yield* _mapPostFixturesEventToState(event.fixture);
    } else if (event is UpdateFixtureEvent) {
      yield* _mapUpdateFixtureEventToState(event.fixture);
    } else if (event is DeleteFixtureEvent) {
      yield* _mapDeleteFixtureEventToState(event.fixtureId);
    }
  }

  Stream<FixtureStates> _mapGetFixturesEventToState() async* {
    yield FixturesFetchingState();
    try {
      List<Fixture> fixtures = await fixturesRepository.getAndSetFixtures();
      if (fixtures.length == 0) {
        yield FixturesEmptyState();
      } else {
        yield FixturesFetchedState(fixtures: fixtures);
      }
    } on HttpException catch (e) {
      yield FixturesFetchingErrorState(message: e.message);
    } catch (e) {
      print(e.toString());
      yield FixturesFetchingErrorState();
    }
  }

  Stream<FixtureStates> _mapPostFixturesEventToState(Fixture fixture) async* {
    yield FixturePostingState();
    try {
      await fixturesRepository.postFixture(fixture);
      yield FixturePostedState();
    } on HttpException catch (e) {
      yield FixturePostingErrorState(message: e.message);
    } catch (e) {
      yield FixturePostingErrorState();
    }
  }

  Stream<FixtureStates> _mapUpdateFixtureEventToState(Fixture fixture) async* {
    yield FixtureUpdatingState();
    try {
      await fixturesRepository.putFixture(fixture);
      yield FixtureUpdatedState();
    } on HttpException catch (e) {
      yield FixtureUpdatingErrorState(message: e.message);
    } catch (e) {
      yield FixtureUpdatingErrorState();
    }
  }

  Stream<FixtureStates> _mapDeleteFixtureEventToState(String fixtureId) async* {
    yield FixtureDeletingState();
    try {
      await fixturesRepository.deleteFixture(fixtureId);
      yield FixtureDeletedState();
    } on HttpException catch (e) {
      yield FixturesDeletingErrorState(message: e.message);
    } catch (e) {
      yield FixturesDeletingErrorState();
    }
  }
}
