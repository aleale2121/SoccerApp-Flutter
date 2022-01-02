import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../models/result.dart';
import '../../models/http_exception.dart';
import '../../repository/result_repository.dart';
import 'results_event.dart';
import 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultStates> {
  final ResultRepository resultRepository;
  ResultsBloc({required this.resultRepository})
      : super(ResultUninitializedState());

  
  Stream<ResultStates> mapEventToState(ResultsEvent event) async* {
    if (event is GetResultsEvent) {
      yield* _mapGetResultsEventToState();
    } else if (event is PostResultEvent) {
      yield* _mapPostResultEventToState(event.result);
    } else if (event is UpdateResultEvent) {
      yield* _mapUpdateResultEventToState(event.result);
    } else if (event is DeleteResultEvent) {
      yield* _mapDeleteResultEventToState(event.resultId);
    }
  }

  Stream<ResultStates> _mapGetResultsEventToState() async* {
    print('------------bloc fetching result------');

    yield ResultsFetchingState();
    try {
      List<Result> results = await resultRepository.getAndSetResults();
      if (results.length == 0) {
        yield ResultsEmptyState();
      } else {
        yield ResultsFetchedState(results: results);
      }
    } on HttpException catch (e) {
      yield ResultsFetchingErrorState(message: e.message);
    } catch (e) {
      yield ResultsFetchingErrorState();
    }
  }

  Stream<ResultStates> _mapPostResultEventToState(Result result) async* {
    yield ResultPostingState();
    try {
      await resultRepository.postResult(result);
      yield ResultPostedState();
    } on HttpException catch (e) {
      yield ResultPostingErrorState(message: e.message);
    } catch (e) {
      yield ResultPostingErrorState();
    }
  }

  Stream<ResultStates> _mapUpdateResultEventToState(Result result) async* {
    yield ResultUpdatingState();
    try {
      await resultRepository.putResult(result);
      yield ResultUpdatedState();
    } on HttpException catch (e) {
      yield ResultUpdatingErrorState(message: e.message);
    } catch (e) {
      yield ResultUpdatingErrorState();
    }
  }

  Stream<ResultStates> _mapDeleteResultEventToState(String resultId) async* {
    yield ResultDeletingState();
    try {
      await resultRepository.deleteResult(resultId);
      yield ResultDeletedState();
    } on HttpException catch (e) {
      yield ResultsDeletingErrorState(message: e.message);
    } catch (e) {
      yield ResultsDeletingErrorState();
    }
  }
}
