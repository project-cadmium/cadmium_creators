import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.instructorId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int instructorId;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  static const empty = Course(
    id: -1,
    instructorId: -1,
    name: "",
    description: "",
    createdAt: "",
    updatedAt: "",
  );

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json["id"],
      instructorId: json["user_id"],
      name: json["name"],
      description: json["description"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  @override
  List<Object> get props =>
      [id, instructorId, name, description, createdAt, updatedAt];
}
