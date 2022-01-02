import 'package:flutter/foundation.dart';
import '../../models/result.dart';

abstract class ResultStates {}

class ResultUninitializedState extends ResultStates {}

class ResultsFetchingState extends ResultStates {}

class ResultsFetchedState extends ResultStates {
  final List<Result> results;
  ResultsFetchedState({required this.results});
}

class ResultsFetchingErrorState extends ResultStates {
  final String? message;

  ResultsFetchingErrorState({this.message});
}

class ResultDeletingState extends ResultStates {}

class ResultDeletedState extends ResultStates {}

class ResultsDeletingErrorState extends ResultStates {
  final String? message;

  ResultsDeletingErrorState({this.message});
}

class ResultPostingState extends ResultStates {}

class ResultPostedState extends ResultStates {}

class ResultPostingErrorState extends ResultStates {
  final String? message;

  ResultPostingErrorState({this.message});
}

class ResultUpdatingState extends ResultStates {}

class ResultUpdatedState extends ResultStates {}

class ResultUpdatingErrorState extends ResultStates {
  final String? message;
  ResultUpdatingErrorState({this.message});
}

class ResultsEmptyState extends ResultStates {}
