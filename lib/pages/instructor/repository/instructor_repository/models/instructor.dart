import 'package:equatable/equatable.dart';

class Instructor extends Equatable {
  const Instructor({
    required this.id,
    required this.userId,
    required this.biography,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int userId;
  final String biography;
  final String createdAt;
  final String updatedAt;

  static const empty = Instructor(
    id: -1,
    userId: -1,
    biography: "",
    createdAt: "",
    updatedAt: "",
  );

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json["id"],
      userId: json["user_id"],
      biography: json["biography"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  @override
  List<Object> get props => [id, userId, biography, createdAt, updatedAt];
}
