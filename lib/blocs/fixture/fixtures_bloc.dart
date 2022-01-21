import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soccer_app/models/custom_exception.dart';
import '../../models/fixture.dart';
import '../../repository/fixture_repository.dart';
import 'fixtures_event.dart';
import 'fixtures_state.dart';

class FixturesBloc extends Bloc<FixtureEvents, FixtureStates> {
  FixtureRepository _fixturesRepository;

  FixturesBloc({required FixtureRepository fixturesRepository})
      : _fixturesRepository = fixturesRepository,
        super(FixturesFetchingState()) {
    on<LoadFixtures>(_onLoadFixtures);
    on<AddFixture>(_onAddFixture);
    on<UpdateFixture>(_onUpdateFixture);
    on<DeleteFixture>(_onDeleteFixture);
    on<FixturesUpdated>(_onFixturesUpdated);
  }

  Future<void> _onLoadFixtures(
      LoadFixtures event, Emitter<FixtureStates> emit) {
    return emit.onEach<List<Fixture>>(
      _fixturesRepository.fixtures(),
      onData: (fixtures) => add(FixturesUpdated(fixtures: fixtures)),
    );
  }

  void _onAddFixture(AddFixture event, Emitter<FixtureStates> emit) {
    emit(FixturePostingState());
    try {
      _fixturesRepository.addFixture(event.fixture);
      emit(FixturePostedState());
    } on CustomException catch (e) {
      emit(FixturePostingErrorState(message: e.cause));
    } catch (e) {
      emit(FixturePostingErrorState(message: "Failed To Add Fixture"));
    }
  }

  void _onUpdateFixture(UpdateFixture event, Emitter<FixtureStates> emit) {
    emit(FixtureUpdatingState());
    try {
      _fixturesRepository.updateFixture(event.fixture);
      emit(FixtureUpdatedState());
    } on CustomException catch (e) {
      emit(FixtureUpdatingErrorState(message: e.cause));
    } catch (e) {
      emit(FixtureUpdatingErrorState(message: "Failed To Update Fixture"));
    }
  }

  void _onDeleteFixture(DeleteFixture event, Emitter<FixtureStates> emit) {
    emit(FixtureDeletingState());
    try {
      _fixturesRepository.deleteFixture(event.fixtureId);
      emit(FixtureDeletedState());
    } on CustomException catch (e) {
      emit(FixturesDeletingErrorState(message: e.cause));
    } catch (e) {
      emit(
        FixturesDeletingErrorState(message: "Failed To Delete Fixture"),
      );
    }
  }
  void _onFixturesUpdated(FixturesUpdated event, Emitter<FixtureStates> emit) {
    emit(FixturesFetchedState(fixtures: event.fixtures));
  }
}
