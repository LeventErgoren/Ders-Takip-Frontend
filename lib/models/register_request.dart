class RegisterRequest {
  final String username;
  final String password;
  final String firstname;
  final String lastname;
  final String email;

  RegisterRequest({
    required this.username,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        username: json["username"],
        password: json["password"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
  };
}
