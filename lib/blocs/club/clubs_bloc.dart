import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../models/club.dart';
import '../../models/http_exception.dart';
import '../../repository/club_repository.dart';
import 'clubs_event.dart';
import 'clubs_state.dart';

class ClubsBloc extends Bloc<ClubEvents, ClubStates> {
  final ClubRepository clubsRepository;

  ClubsBloc({@required this.clubsRepository}) : super(ClubUninitializedState());

  @override
  Stream<ClubStates> mapEventToState(ClubEvents event) async* {
    if (event is GetClubsEvent) {
      yield* _mapGetClubsEventToState();
    } else if (event is PostClubEvent) {
      yield* _mapPostClubsEventToState(event.club);
    } else if (event is UpdateClubEvent) {
      yield* _mapUpdateClubEventToState(event.club);
    } else if (event is DeleteClubEvent) {
      yield* _mapDeleteClubEventToState(event.clubId);
    }
  }

  Stream<ClubStates> _mapGetClubsEventToState() async* {
    yield ClubsFetchingState();
    try {
      List<Club> clubs = await clubsRepository.getAndSetClubs();
      if (clubs.length == 0) {
        yield ClubsEmptyState();
      } else {
        yield ClubFetchedState(clubs: clubs);
      }
    } on HttpException catch (e) {
      yield ClubsFetchingErrorState(message: e.message);
    } catch (e) {
      yield ClubsFetchingErrorState();
    }
  }

  Stream<ClubStates> _mapPostClubsEventToState(Club club) async* {
    yield ClubPostingState();
    try {
      await clubsRepository.postClub(club);
      yield ClubPostedState();
    } on HttpException catch (e) {
      yield ClubPostingErrorState(message: e.message);
    } catch (e) {
      yield ClubPostingErrorState();
    }
  }

  Stream<ClubStates> _mapUpdateClubEventToState(Club club) async* {
    yield ClubUpdatingState();
    try {
      await clubsRepository.putClub(club);
      yield ClubUpdatedState();
    } on HttpException catch (e) {
      yield ClubUpdatingErrorState(message: e.message);
    } catch (e) {
      yield ClubUpdatingErrorState();
    }
  }

  Stream<ClubStates> _mapDeleteClubEventToState(String clubId) async* {
    yield ClubDeletingState();
    try {
      await clubsRepository.deleteClub(clubId);
      yield ClubDeletedState();
    } on HttpException catch (e) {
      yield ClubsDeletingErrorState(message: e.message);
    } catch (e) {
      yield ClubsDeletingErrorState();
    }
  }
}
