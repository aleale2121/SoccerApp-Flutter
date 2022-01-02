import 'dart:convert';

import '../models/club.dart';

class Scorer {
  final int id;
  final int resultID;
  final String scorerName;
  final int scoringMinute;
  final int clubId;
  final Club club;
  Scorer({
    required this.id,
    required this.resultID,
    required this.scorerName,
    required this.scoringMinute,
    required this.clubId,
    required this.club,
  });


  Scorer copyWith({
    int? id,
    int? resultID,
    String? scorerName,
    int? scoringMinute,
    int? clubId,
    Club? club,
  }) {
    return Scorer(
      id: id ?? this.id,
      resultID: resultID ?? this.resultID,
      scorerName: scorerName ?? this.scorerName,
      scoringMinute: scoringMinute ?? this.scoringMinute,
      clubId: clubId ?? this.clubId,
      club: club ?? this.club,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resultID': resultID,
      'scorerName': scorerName,
      'scoringMinute': scoringMinute,
      'clubId': clubId,
      'club': club.toMap(),
    };
  }

  factory Scorer.fromMap(Map<String, dynamic> map) {
    return Scorer(
      id: map['id']?.toInt() ?? 0,
      resultID: map['resultID']?.toInt() ?? 0,
      scorerName: map['scorerName'] ?? '',
      scoringMinute: map['scoringMinute']?.toInt() ?? 0,
      clubId: map['clubId']?.toInt() ?? 0,
      club: Club.fromMap(map['club']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Scorer.fromJson(String source) => Scorer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Scorer(id: $id, resultID: $resultID, scorerName: $scorerName, scoringMinute: $scoringMinute, clubId: $clubId, club: $club)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Scorer &&
      other.id == id &&
      other.resultID == resultID &&
      other.scorerName == scorerName &&
      other.scoringMinute == scoringMinute &&
      other.clubId == clubId &&
      other.club == club;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      resultID.hashCode ^
      scorerName.hashCode ^
      scoringMinute.hashCode ^
      clubId.hashCode ^
      club.hashCode;
  }
}
