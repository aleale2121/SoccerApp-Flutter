import 'dart:convert';
import 'package:mockito/mockito.dart';

class Club extends Fake{
  final int id;
  final String name;

  Club({
    required this.id,
    required this.name,
  });

  Club copyWith({
    int? id,
    String? name,
  }) {
    return Club(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Club.fromJson(String source) => Club.fromMap(json.decode(source));

  @override
  String toString() => 'Club(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Club &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
