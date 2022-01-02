import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/fixture.dart';
import '../models/scorer.dart';

class Result {
  final int? id;
  final int fixtureId;
  final Fixture fixture;
  final int firstClubScore;
  final int secondClubScore;
  final List<Scorer>? scorers;
  Result({
    this.id,
    required this.fixtureId,
    required this.fixture,
    required this.firstClubScore,
    required this.secondClubScore,
     this.scorers,
  });


  Result copyWith({
    int? id,
    int? fixtureId,
    Fixture? fixture,
    int? firstClubScore,
    int? secondClubScore,
    List<Scorer>? scorers,
  }) {
    return Result(
      id: id ?? this.id,
      fixtureId: fixtureId ?? this.fixtureId,
      fixture: fixture ?? this.fixture,
      firstClubScore: firstClubScore ?? this.firstClubScore,
      secondClubScore: secondClubScore ?? this.secondClubScore,
      scorers: scorers ?? this.scorers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fixtureId': fixtureId,
      'fixture': fixture.toMap(),
      'firstClubScore': firstClubScore,
      'secondClubScore': secondClubScore,
      'scorers': scorers?.map((x) => x.toMap()).toList(),
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id']?.toInt() ?? 0,
      fixtureId: map['fixtureId']?.toInt() ?? 0,
      fixture: Fixture.fromMap(map['fixture']),
      firstClubScore: map['firstClubScore']?.toInt() ?? 0,
      secondClubScore: map['secondClubScore']?.toInt() ?? 0,
      scorers: List<Scorer>.from(map['scorers']?.map((x) => Scorer.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(id: $id, fixtureId: $fixtureId, fixture: $fixture, firstClubScore: $firstClubScore, secondClubScore: $secondClubScore, scorers: $scorers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result &&
      other.id == id &&
      other.fixtureId == fixtureId &&
      other.fixture == fixture &&
      other.firstClubScore == firstClubScore &&
      other.secondClubScore == secondClubScore &&
      listEquals(other.scorers, scorers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fixtureId.hashCode ^
      fixture.hashCode ^
      firstClubScore.hashCode ^
      secondClubScore.hashCode ^
      scorers.hashCode;
  }
}
