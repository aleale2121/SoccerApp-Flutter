import 'package:meta/meta.dart';
import '../data_provider/data.dart';
import '../models/model.dart';

class ClubRepository {
  final ClubDataProvider clubDataProvider;

  ClubRepository({@required this.clubDataProvider});

  Future<List<Club>> getAndSetClubs() async {
    return await clubDataProvider.getAndSetClubs();
  }

  Future<Club> getClub(String clubId) async {
    return await clubDataProvider.getClub(clubId);
  }

  Future<Club> postClub(Club club) async {
    return await clubDataProvider.postClub(club);
  }

  Future<Club> putClub(Club club) async {
    return await clubDataProvider.putClub(club);
  }

  Future<void> deleteClub(String id) async {
    return await clubDataProvider.deleteClub(id);
  }
}
