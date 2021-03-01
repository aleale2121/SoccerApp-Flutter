import '../models/scorer.dart';

import '../models/fixture.dart';

class Result {
  int id;
  int fixtureId;
  Fixture fixture;
  int firstClubScore;
  int secondClubScore;
  List<Scorer> scorers;

  Result(
      {this.id,
      this.fixtureId,
      this.fixture,
      this.firstClubScore,
      this.secondClubScore,
      this.scorers});
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json["id"],
      fixtureId: json["fixture_id"],
      fixture: Fixture.fromJson(json["fixture"]),
      firstClubScore: json["first_club_score"],
      secondClubScore: json["second_club_score"],
      scorers: (json["scorers"] as List)
          .map<Scorer>((json) => Scorer.fromJson(json))
          .toList(),
    );
  }
}
