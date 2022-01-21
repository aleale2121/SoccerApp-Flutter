import 'dart:convert';

class LiveDescription {
  final int minute;
  final String description;
  LiveDescription({
    required this.minute,
    required this.description,
  });

  LiveDescription copyWith({
    int? minute,
    String? description,
  }) {
    return LiveDescription(
      minute: minute ?? this.minute,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'minute': minute,
      'description': description,
    };
  }

  factory LiveDescription.fromMap(Map<String, dynamic> map) {
    return LiveDescription(
      minute: map['minute']?.toInt() ?? 0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveDescription.fromJson(String source) => LiveDescription.fromMap(json.decode(source));

  @override
  String toString() => 'LiveDescription(minute: $minute, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LiveDescription &&
      other.minute == minute &&
      other.description == description;
  }

  @override
  int get hashCode => minute.hashCode ^ description.hashCode;
}
