part of 'a_bloc.dart';

abstract class AState extends Equatable {
  const AState();
  
  @override
  List<Object> get props => [];
}

class AInitial extends AState {}
