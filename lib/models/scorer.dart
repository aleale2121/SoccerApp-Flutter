import '../models/club.dart';

class Scorer {
  int id;
  int resultID;
  String scorerName;
  int scoringMinute;
  int clubId;
  Club club;

  Scorer(
      {this.id,
      this.resultID,
      this.scorerName,
      this.scoringMinute,
      this.clubId,
      this.club});

  factory Scorer.fromJson(Map<String, dynamic> json) {
    return Scorer(
      id: json["id"],
      resultID: json["result_id"],
      scorerName: json["scorer_name"],
      scoringMinute: json["scoring_minute"],
      clubId: json["club_id"],
      club: Club.fromJson(json["club"]),
    );
  }
  Map toJson() => {
        'id': id,
        'result_id': resultID,
        'scorer_name': scorerName,
        'scoring_minute': scoringMinute,
        'club_id': clubId,
        'club': club,
      };
}
