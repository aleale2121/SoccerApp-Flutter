import 'dart:convert';

class Goal {
  final String scorerName;
  final String scoringMinute;
  final String clubName;
  Goal({
    required this.scorerName,
    required this.scoringMinute,
    required this.clubName,
  });

  Goal copyWith({
    String? scorerName,
    String? scoringMinute,
    String? clubName,
  }) {
    return Goal(
      scorerName: scorerName ?? this.scorerName,
      scoringMinute: scoringMinute ?? this.scoringMinute,
      clubName: clubName ?? this.clubName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'scorerName': scorerName,
      'scoringMinute': scoringMinute,
      'clubName': clubName,
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      scorerName: map['scorerName'] ?? '',
      scoringMinute: map['scoringMinute'] ?? '',
      clubName: map['clubName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) => Goal.fromMap(json.decode(source));

  @override
  String toString() => 'Score(scorerName: $scorerName, scoringMinute: $scoringMinute, clubName: $clubName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Goal &&
      other.scorerName == scorerName &&
      other.scoringMinute == scoringMinute &&
      other.clubName == clubName;
  }

  @override
  int get hashCode => scorerName.hashCode ^ scoringMinute.hashCode ^ clubName.hashCode;
}
