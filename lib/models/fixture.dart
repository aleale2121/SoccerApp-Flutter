import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soccer_app/models/result.dart';

class Fixture {
  final String? id;
  final DateTime matchDate;
  final double? stadiumLatitude;
  final double? stadiumLongitude;
  final String stadiumName;
  final String refreeName;
  final String firstClub;
  final String secondClub;
  final String status;
   Result? result;
  Fixture({
    this.id,
    required this.matchDate,
    this.stadiumLatitude,
    this.stadiumLongitude,
    required this.stadiumName,
    required this.refreeName,
    required this.firstClub,
    required this.secondClub,
    this.status = "not started",
    this.result,
  });

  Fixture copyWith({
    String? id,
    DateTime? startingDate,
    double? stadiumLatitude,
    double? stadiumLongitude,
    String? stadiumName,
    String? refreeName,
    String? firstClub,
    String? secondClub,
    final Result? result,
  }) {
    return Fixture(
      id: id ?? this.id,
      matchDate: startingDate ?? this.matchDate,
      stadiumLatitude: stadiumLatitude ?? this.stadiumLatitude,
      stadiumLongitude: stadiumLongitude ?? this.stadiumLongitude,
      stadiumName: stadiumName ?? this.stadiumName,
      refreeName: refreeName ?? this.refreeName,
      firstClub: firstClub ?? this.firstClub,
      secondClub: secondClub ?? this.secondClub,
      result: result?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matchDate': matchDate.toString(),
      'stadiumLatitude': stadiumLatitude,
      'stadiumLongitude': stadiumLongitude,
      'stadiumName': stadiumName,
      'refreeName': refreeName,
      'firstClub': firstClub,
      'secondClub': secondClub,
    };
  }

  Map<String, dynamic> toSnapshoot() {
    return {
      'matchDate': matchDate.toString(),
      'stadiumLatitude': stadiumLatitude,
      'stadiumLongitude': stadiumLongitude,
      'stadiumName': stadiumName,
      'refreeName': refreeName,
      'firstClub': firstClub,
      'secondClub': secondClub,
    };
  }

  factory Fixture.fromMap(Map<String, dynamic> map) {
    return Fixture(
      id: map['id'],
      matchDate: DateTime.parse(map['matchDate']),
      stadiumLatitude: map['stadiumLatitude']?.toDouble(),
      stadiumLongitude: map['stadiumLongitude']?.toDouble(),
      stadiumName: map['stadiumName'] ?? '',
      refreeName: map['refreeName'] ?? '',
      firstClub: map['firstClub'] ?? '',
      secondClub: map['secondClub'] ?? '',
    );
  }

  factory Fixture.fromSnapshoot(DocumentSnapshot snap) {
    // String machDate = snap.get('matchDate');
    return Fixture(
        id: snap.id,
        firstClub: snap.get('firstClub'),
        secondClub: snap.get('secondClub'),
        stadiumLatitude: double.parse(snap.get('stadiumLatitude').toString()),
        stadiumLongitude: double.parse(snap.get('stadiumLongitude').toString()),
        stadiumName: snap.get('stadiumName') ?? '',
        refreeName: snap.get('refreeName') ?? '',
        matchDate: DateTime.now()
        // matchDate: DateTime.parse(snap.get('matchDate')),
        );
  }

  String toJson() => json.encode(toMap());

  factory Fixture.fromJson(String source) =>
      Fixture.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fixture(id: $id, matchDate: $matchDate, stadiumLatitude: $stadiumLatitude, stadiumLongitude: $stadiumLongitude, stadiumName: $stadiumName, refreeName: $refreeName, firstClub: $firstClub, secondClub: $secondClub)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fixture &&
        other.id == id &&
        other.matchDate == matchDate &&
        other.stadiumLatitude == stadiumLatitude &&
        other.stadiumLongitude == stadiumLongitude &&
        other.stadiumName == stadiumName &&
        other.refreeName == refreeName &&
        other.firstClub == firstClub &&
        other.secondClub == secondClub &&
        other.result==result;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        matchDate.hashCode ^
        stadiumLatitude.hashCode ^
        stadiumLongitude.hashCode ^
        stadiumName.hashCode ^
        refreeName.hashCode ^
        firstClub.hashCode ^
        secondClub.hashCode ^
        result.hashCode;
  }
}
