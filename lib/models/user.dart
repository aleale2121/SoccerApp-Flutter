class User {
  int id;
  String fullName;
  String email;
  String password;
  String phone;
  Role role;
  int roleId;
  User({this.email, this.password});
  User.fullInfo({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.phone,
    this.roleId,
    this.role,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User.fullInfo(
      id: json["id"],
      fullName: json["full_name"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
      roleId: json["role_id"],
      role: Role.fromJson(json["role"]),
    );
  }
}

class Role {
  int id;
  String name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json["id"],
      name: json["name"],
    );
  }
}
