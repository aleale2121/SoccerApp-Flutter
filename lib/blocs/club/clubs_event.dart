import 'package:equatable/equatable.dart';

import '../../models/club.dart';

abstract class ClubEvents extends Equatable {}

class LoadClubs extends ClubEvents {
  LoadClubs();
  @override
  List<Object> get props => [];
}

class PostClub extends ClubEvents {
  final Club club;
  PostClub({required this.club});
  @override
  List<Object> get props => [];
}

class UpdateClub extends ClubEvents {
  final Club club;
  UpdateClub({required this.club});
  @override
  List<Object> get props => [];
}

class DeleteClub extends ClubEvents {
  final String clubId;
  DeleteClub({required this.clubId});

  @override
  List<Object> get props => [];
}

class ClubsUpdated extends ClubEvents {
  final List<Club> clubs;
  ClubsUpdated({
    required this.clubs,
  });
  @override
  List<Object?> get props => [];
}
