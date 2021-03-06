part of 'course_form_bloc.dart';

abstract class CourseFormEvent extends Equatable {
  const CourseFormEvent();

  @override
  List<Object> get props => [];
}

class CourseFormNameChanged extends CourseFormEvent {
  const CourseFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class CourseFormDescriptionChanged extends CourseFormEvent {
  const CourseFormDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class CourseFormCreateSubmitted extends CourseFormEvent {
  const CourseFormCreateSubmitted(
      {required this.instructorId, required this.token});

  final int instructorId;
  final String token;

  @override
  List<Object> get props => [instructorId, token];
}

class CourseFormUpdateInitial extends CourseFormEvent {
  const CourseFormUpdateInitial(
      {required this.name, required this.description});

  final String name;
  final String description;

  @override
  List<Object> get props => [name, description];
}

class CourseFormUpdateSubmitted extends CourseFormEvent {
  const CourseFormUpdateSubmitted(
      {required this.courseId,
      required this.instructorId,
      required this.token});

  final int courseId;
  final int instructorId;
  final String token;

  @override
  List<Object> get props => [courseId, instructorId, token];
}
