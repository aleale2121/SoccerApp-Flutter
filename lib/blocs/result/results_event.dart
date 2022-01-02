import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../models/result.dart';

abstract class ResultsEvent extends Equatable {}

class GetResultsEvent extends ResultsEvent {
  GetResultsEvent();
  @override
  List<Object> get props => [];
}

class PostResultEvent extends ResultsEvent {
  final Result result;
  PostResultEvent({required this.result});
  @override
  List<Object> get props => [];
}

class UpdateResultEvent extends ResultsEvent {
  final Result result;
  UpdateResultEvent({required this.result});
  @override
  List<Object> get props => [];
}

class DeleteResultEvent extends ResultsEvent {
  final String resultId;
  DeleteResultEvent({required this.resultId});

  @override
  List<Object> get props => [];
}
