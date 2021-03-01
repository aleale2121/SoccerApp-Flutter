import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../models/club.dart';

abstract class ClubEvents extends Equatable {}

class GetClubsEvent extends ClubEvents {
  GetClubsEvent();
  @override
  List<Object> get props => [];
}

class PostClubEvent extends ClubEvents {
  final Club club;
  PostClubEvent({@required this.club});
  @override
  List<Object> get props => [];
}

class UpdateClubEvent extends ClubEvents {
  final Club club;
  UpdateClubEvent({@required this.club});
  @override
  List<Object> get props => [];
}

class DeleteClubEvent extends ClubEvents {
  final String clubId;
  DeleteClubEvent({@required this.clubId});

  @override
  List<Object> get props => [];
}
