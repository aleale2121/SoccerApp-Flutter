import 'package:equatable/equatable.dart';
import '../../models/result.dart';

abstract class ResultsEvent extends Equatable {
  const ResultsEvent();
  @override
  List<Object> get props => [];
}

class LoadResults extends ResultsEvent {}

class AddResult extends ResultsEvent {
  final Result result;
  const AddResult({required this.result});
  @override
  List<Object> get props => [result];
}

class UpdateResult extends ResultsEvent {
  final Result result;
  const UpdateResult({required this.result});
  @override
  List<Object> get props => [result];
}

class DeleteResult extends ResultsEvent {
  final String resultId;
  const DeleteResult({required this.resultId});

  @override
  List<Object> get props => [resultId];
}

class ResultsUpdated extends ResultsEvent {
  final List<Result> results;
  const ResultsUpdated({
    required this.results,
  });
  @override
  List<Object> get props => [results];
}
