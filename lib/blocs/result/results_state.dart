import 'package:equatable/equatable.dart';
import '../../models/result.dart';

abstract class ResultStates extends Equatable {
  const ResultStates();
  @override
  List<Object> get props => [];
}

class ResultUninitializedState extends ResultStates {}

class ResultsFetchingState extends ResultStates {}

class ResultsFetchedState extends ResultStates {
  final List<Result> results;
  ResultsFetchedState({required this.results});
  @override
  List<Object> get props => [results];
}

class ResultsFetchingErrorState extends ResultStates {
  final String message;

  ResultsFetchingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ResultDeletingState extends ResultStates {}

class ResultDeletedState extends ResultStates {}

class ResultsDeletingErrorState extends ResultStates {
  final String message;

  ResultsDeletingErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class ResultPostingState extends ResultStates {}

class ResultPostedState extends ResultStates {}

class ResultPostingErrorState extends ResultStates {
  final String message;

  ResultPostingErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class ResultUpdatingState extends ResultStates {}

class ResultUpdatedState extends ResultStates {}

class ResultUpdatingErrorState extends ResultStates {
  final String message;
  ResultUpdatingErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class ResultsEmptyState extends ResultStates {}
