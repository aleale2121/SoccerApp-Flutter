import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Club {
  String? id;
  final String name;
  String? logoUrl;
  Club({
    this.id,
    required this.name,
    this.logoUrl,
  });

  Club copyWith({
    String? id,
    String? name,
    String? logoUrl,
  }) {
    return Club(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
    };
  }

  Map<String, dynamic> toSnap() {
    return {
      'name': name,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      id: map['id'],
      name: map['name'] ?? '',
      logoUrl: map['logoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Club.fromJson(String source) => Club.fromMap(json.decode(source));

  factory Club.fromSnapshoot(DocumentSnapshot snap) {
    return Club(
      id: snap.id,
      name: snap.get('name') ?? '',
    );
  }

  @override
  String toString() => 'Club(id: $id, name: $name, logoUrl: $logoUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Club &&
      other.id == id &&
      other.name == name &&
      other.logoUrl == logoUrl;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logoUrl.hashCode;
}
