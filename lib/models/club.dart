class Club {
  int id;
  String name;

  Club({this.id, this.name});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json["id"],
      name: json["club_name"],
    );
  }
  Map toJson() => {
        'id': id,
        'club_name': name,
      };
}
