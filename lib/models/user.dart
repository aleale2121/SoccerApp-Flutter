import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UsersInfo {
  String displayName;
  String email;
  String password;
  String phone;
  String role;
  String? uuid;
  UsersInfo({
    required this.displayName,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
     this.uuid,
  });

  UsersInfo copyWith({
    String? displayName,
    String? email,
    String? password,
    String? phone,
    String? role,
    String? uuid,
  }) {
    return UsersInfo(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      'uuid': uuid,
    };
  }

  factory UsersInfo.fromMap(Map<String, dynamic> map) {
    return UsersInfo(
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      uuid: map['uuid'] ?? '',
    );
  }

  factory UsersInfo.fromSnapshoot(DocumentSnapshot snap) {
    return UsersInfo(
      displayName: snap['displayName'] ?? '',
      email: snap['email'] ?? '',
      password: snap['password'] ?? '',
      phone: snap['phone'] ?? '',
      role: snap['role'] ?? '',
      uuid: snap['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersInfo.fromJson(String source) => UsersInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(displayName: $displayName, email: $email, password: $password, phone: $phone, role: $role, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersInfo &&
      other.displayName == displayName &&
      other.email == email &&
      other.password == password &&
      other.phone == phone &&
      other.role == role &&
      other.uuid == uuid;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      role.hashCode ^
      uuid.hashCode;
  }
}
