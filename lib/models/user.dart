import 'dart:convert';

class User {
  int? id;
  String fullName;
  String email;
  String password;
  String phone;
  Role? role;
  int roleId;
  User({
     this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
     this.role,
    required this.roleId,
  });


  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? password,
    String? phone,
    Role? role,
    int? roleId,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      roleId: roleId ?? this.roleId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role?.toMap(),
      'roleId': roleId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      role: Role.fromMap(map['role']),
      roleId: map['roleId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, email: $email, password: $password, phone: $phone, role: $role, roleId: $roleId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
      other.id == id &&
      other.fullName == fullName &&
      other.email == email &&
      other.password == password &&
      other.phone == phone &&
      other.role == role &&
      other.roleId == roleId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      role.hashCode ^
      roleId.hashCode;
  }
}

class Role {
  int? id;
  String name;
  Role({
     this.id,
    required this.name,
  });



  Role copyWith({
    int? id,
    String? name,
  }) {
    return Role(
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

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source));

  @override
  String toString() => 'Role(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Role &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
