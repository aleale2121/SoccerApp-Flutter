import 'package:soccer_app/util/util.dart';

import '../models/club.dart';

Util util = new Util();

class Fixture {
  int id;
  DateTime startingDate;
  List<Club> clubs;
  double stadiumLatitude;
  double stadiumLongitude;
  String stadiumName;

  Fixture({
    this.id,
    this.startingDate,
    this.clubs,
    this.stadiumLatitude,
    this.stadiumLongitude,
    this.stadiumName,
  });
  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json["id"],
      clubs: (json["clubs"] as List)
          .map<Club>((json) => Club.fromJson(json))
          .toList(),
      startingDate: util.getDateTimeFromString(json["starting_date"]),
      stadiumLatitude: json["stadium_latitude"] * 1.0,
      stadiumLongitude: json["stadium_longitude"] * 1.0,
      stadiumName: json["referee_name"],
    );
  }
}
