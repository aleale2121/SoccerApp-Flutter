import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soccer_app/models/custom_exception.dart';
import '../../models/result.dart';
import '../../repository/result_repository.dart';
import 'results_event.dart';
import 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultStates> {
  final ResultRepository _resultRepository;
  ResultsBloc({required ResultRepository resultRepository})
      : _resultRepository = resultRepository,
        super(ResultsFetchingState()) {
    on<LoadResults>(_onLoadResults);
    on<AddResult>(_onAddResults);
    on<UpdateResult>(_onUpdateResult);
    on<DeleteResult>(_onDeleteResult);
    on<ResultsUpdated>(_onResultsUpdated);
  }

  Future<void> _onLoadResults(LoadResults event, Emitter<ResultStates> emit) {
    return emit.onEach<List<Result>>(
      _resultRepository.results(),
      onData: (results) => add(ResultsUpdated(results: results)),
    );
  }

  void _onAddResults(AddResult event, Emitter<ResultStates> emit) {
    emit(ResultPostingState());
    try {
      _resultRepository.addResult(event.result);
      emit(ResultPostedState());
    } on CustomException catch (e) {
      emit(ResultPostingErrorState(message: e.cause));
    } catch (e) {
      emit(ResultPostingErrorState(message: "Failed To Add Result"));
    }
  }

  void _onUpdateResult(UpdateResult event, Emitter<ResultStates> emit) {
    emit(ResultUpdatingState());
    try {
      _resultRepository.updateResult(event.result);
      emit(ResultUpdatedState());
    } on CustomException catch (e) {
      emit(ResultUpdatingErrorState(message: e.cause));
    } catch (e) {
      emit(ResultUpdatingErrorState(message: "Failed To Update Result"));
    }
  }

  void _onDeleteResult(DeleteResult event, Emitter<ResultStates> emit) {
    emit(ResultDeletingState());
    try {
      _resultRepository.deleteResult(event.resultId);
      emit(ResultDeletedState());
    } on CustomException catch (e) {
      emit(ResultsDeletingErrorState(message: e.cause));
    } catch (e) {
      emit(ResultsDeletingErrorState(message: "Failed To Delete Result"));
    }
  }

  void _onResultsUpdated(ResultsUpdated event, Emitter<ResultStates> emit) {
    emit(ResultsFetchedState(results: event.results));
  }
}
