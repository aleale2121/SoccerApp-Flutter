import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:soccer_app/util/util.dart';

import '../models/club.dart';

Util util = new Util();

class Fixture {
  final int? id;
  final DateTime startingDate;
  final List<Club> clubs;
  final double stadiumLatitude;
  final double stadiumLongitude;
  final String stadiumName;
  final String? refreeName;
  Fixture({
     this.id,
    required this.startingDate,
    required this.clubs,
    required this.stadiumLatitude,
    required this.stadiumLongitude,
    required this.stadiumName,
     this.refreeName,
  });

  Fixture copyWith({
    int? id,
    DateTime? startingDate,
    List<Club>? clubs,
    double? stadiumLatitude,
    double? stadiumLongitude,
    String? stadiumName,
    String? refreeName,
  }) {
    return Fixture(
      id: id ?? this.id,
      startingDate: startingDate ?? this.startingDate,
      clubs: clubs ?? this.clubs,
      stadiumLatitude: stadiumLatitude ?? this.stadiumLatitude,
      stadiumLongitude: stadiumLongitude ?? this.stadiumLongitude,
      stadiumName: stadiumName ?? this.stadiumName,
      refreeName: refreeName ?? this.refreeName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startingDate': startingDate.millisecondsSinceEpoch,
      'clubs': clubs.map((x) => x.toMap()).toList(),
      'stadiumLatitude': stadiumLatitude,
      'stadiumLongitude': stadiumLongitude,
      'stadiumName': stadiumName,
      'refreeName': refreeName,
    };
  }

  factory Fixture.fromMap(Map<String, dynamic> map) {
    return Fixture(
      id: map['id']?.toInt() ?? 0,
      startingDate: DateTime.fromMillisecondsSinceEpoch(map['startingDate']),
      clubs: List<Club>.from(map['clubs']?.map((x) => Club.fromMap(x))),
      stadiumLatitude: map['stadiumLatitude']?.toDouble() ?? 0.0,
      stadiumLongitude: map['stadiumLongitude']?.toDouble() ?? 0.0,
      stadiumName: map['stadiumName'] ?? '',
      refreeName: map['refreeName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Fixture.fromJson(String source) => Fixture.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fixture(id: $id, startingDate: $startingDate, clubs: $clubs, stadiumLatitude: $stadiumLatitude, stadiumLongitude: $stadiumLongitude, stadiumName: $stadiumName, refreeName: $refreeName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fixture &&
      other.id == id &&
      other.startingDate == startingDate &&
      listEquals(other.clubs, clubs) &&
      other.stadiumLatitude == stadiumLatitude &&
      other.stadiumLongitude == stadiumLongitude &&
      other.stadiumName == stadiumName &&
      other.refreeName == refreeName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      startingDate.hashCode ^
      clubs.hashCode ^
      stadiumLatitude.hashCode ^
      stadiumLongitude.hashCode ^
      stadiumName.hashCode ^
      refreeName.hashCode;
  }
}
