import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  @override
  List<Object> get props => [id, username, email, firstName, lastName];

  static const empty = User(
    id: "",
    username: "",
    email: "",
    firstName: "",
    lastName: "",
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["pk"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"]);
  }
}
