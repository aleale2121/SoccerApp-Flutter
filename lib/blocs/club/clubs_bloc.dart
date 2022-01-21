import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soccer_app/models/custom_exception.dart';
import '../../models/club.dart';
import '../../repository/club_repository.dart';
import 'clubs_event.dart';
import 'clubs_state.dart';

class ClubsBloc extends Bloc<ClubEvents, ClubsState> {
  final ClubRepository _clubsRepository;

  ClubsBloc({required ClubRepository clubsRepository})
      : _clubsRepository = clubsRepository,
        super(ClubsFetchingState()) {
    on<LoadClubs>(_onLoadTodos);
    on<PostClub>(_onAddTodo);
    on<UpdateClub>(_onUpdateTodo);
    on<DeleteClub>(_onDeleteTodo);
    on<ClubsUpdated>(_onClubsUpdated);
  }

  Future<void> _onLoadTodos(LoadClubs event, Emitter<ClubsState> emit) {
    return emit.onEach<List<Club>>(
      _clubsRepository.clubs(),
      onData: (clubs) => add(ClubsUpdated(clubs: clubs)),
    );
  }

  void _onAddTodo(PostClub event, Emitter<ClubsState> emit) {
    emit(ClubPostingState());
    try {
      _clubsRepository.addClub(event.club);
      emit(ClubPostedState());
    } on CustomException catch (e) {
      emit(ClubPostingErrorState(message: e.cause));
    } catch (e) {
      emit(ClubPostingErrorState(message: "Failed To Add Club"));
    }
  }

  void _onUpdateTodo(UpdateClub event, Emitter<ClubsState> emit) {
    emit(ClubUpdatingState());
    try {
      _clubsRepository.updateClub(event.club);
      emit(ClubUpdatedState());
    } on CustomException catch (e) {
      emit(ClubUpdatingErrorState(message: e.cause));
    } catch (e) {
      emit(ClubUpdatingErrorState(message: "Failed To Update Clube"));
    }
  }

  void _onDeleteTodo(DeleteClub event, Emitter<ClubsState> emit) {
    emit(ClubDeletingState());
    try {
      _clubsRepository.deleteClub(event.clubId);
      emit(ClubDeletedState());
    } on CustomException catch (e) {
      emit(ClubsDeletingErrorState(message: e.cause));
    } catch (e) {
      emit(ClubsDeletingErrorState(message: "Failed To Delete Club"));
    }
  }

  void _onClubsUpdated(ClubsUpdated event, Emitter<ClubsState> emit) {
    emit(ClubFetchedState(clubs: event.clubs));
  }
}