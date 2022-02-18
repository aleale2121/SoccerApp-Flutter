import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:soccer_app/models/live_description.dart';

import '../models/fixture.dart';
import '../models/scorer.dart';

class Result {
  final String? id;
  final String fixtureId;
   Fixture? fixture;
  final int firstClubScore;
  final int secondClubScore;
  final List<Goal> goals;
  List<LiveDescription> liveDescription;

  Result({
    this.id,
    required this.fixtureId,
    this.fixture,
    required this.firstClubScore,
    required this.secondClubScore,
    required this.goals,
    this.liveDescription = const [],
  });

  Result copyWith({
    String? id,
    String? fixtureId,
    Fixture? fixture,
    int? firstClubScore,
    int? secondClubScore,
    List<Goal>? scores,
    List<LiveDescription>? liveDescription,
  }) {
    return Result(
      id: id ?? this.id,
      fixtureId: fixtureId ?? this.fixtureId,
      fixture: fixture ?? this.fixture,
      firstClubScore: firstClubScore ?? this.firstClubScore,
      secondClubScore: secondClubScore ?? this.secondClubScore,
      goals: scores ?? this.goals,
      liveDescription: liveDescription ?? this.liveDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fixtureId': fixtureId,
      'fixture': fixture?.toMap(),
      'firstClubScore': firstClubScore,
      'secondClubScore': secondClubScore,
      'scores': goals.map((x) => x.toMap()).toList(),
      'liveDescription': liveDescription.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, dynamic> toSnap() {
    return {
      'fixtureId': fixtureId,
      'firstClubScore': firstClubScore,
      'secondClubScore': secondClubScore,
      'scores': goals.map((x) => x.toMap()).toList(),
      'liveDescription': liveDescription.map((x) => x.toMap()).toList(),
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'],
      fixtureId: map['fixtureId'] ?? '',
      fixture: Fixture.fromMap(map['fixture']),
      firstClubScore: map['firstClubScore']?.toInt() ?? 0,
      secondClubScore: map['secondClubScore']?.toInt() ?? 0,
      goals: List<Goal>.from(map['scores']?.map((x) => Goal.fromMap(x))),
      liveDescription: List<LiveDescription>.from(
          map['liveDescription']?.map((x) => LiveDescription.fromMap(x))),
    );
  }

  factory Result.fromSnap(DocumentSnapshot snapshot) {
    return Result(
      id: snapshot.id,
      fixtureId: snapshot['fixtureId'] ?? '',
      firstClubScore: snapshot['firstClubScore']?.toInt() ?? 0,
      secondClubScore: snapshot['secondClubScore']?.toInt() ?? 0,
      goals: List<Goal>.from(snapshot['scores']?.map((x) => Goal.fromMap(x))),
      liveDescription: List<LiveDescription>.from(
          snapshot['liveDescription']?.map((x) => LiveDescription.fromMap(x))),
    );
  }
  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(id: $id, fixtureId: $fixtureId, fixture: $fixture, firstClubScore: $firstClubScore, secondClubScore: $secondClubScore, scores: $goals)';
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
        listEquals(other.goals, goals);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fixtureId.hashCode ^
        fixture.hashCode ^
        firstClubScore.hashCode ^
        secondClubScore.hashCode ^
        goals.hashCode;
  }
}
