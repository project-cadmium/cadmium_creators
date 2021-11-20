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
      {required this.courseId, required this.token});

  final int courseId;
  final String token;

  @override
  List<Object> get props => [courseId, token];
}

class CourseFormUpdateSubmitted extends CourseFormEvent {
  const CourseFormUpdateSubmitted(
      {required this.courseId, required this.token});

  final int courseId;
  final String token;

  @override
  List<Object> get props => [courseId, token];
}
