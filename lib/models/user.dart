class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime creationDate;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.creationDate,
  });

  @override
  String toString() {
    return "id: $id firstname: $firstname lastname: $lastname email $email creationDate: $creationDate";
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    creationDate: DateTime.parse(json["creationDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "creationDate": creationDate.toIso8601String(),
  };
}
