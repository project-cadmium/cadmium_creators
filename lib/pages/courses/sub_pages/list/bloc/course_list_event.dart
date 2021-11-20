part of 'course_list_bloc.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object> get props => [];
}

class GetCourseListSuccessful extends CourseListEvent {
  const GetCourseListSuccessful(this.courses);

  final List<Course> courses;

  @override
  List<Object> get props => [courses];
}

class GetCourseListInitial extends CourseListEvent {
  const GetCourseListInitial({required this.instructorId, required this.token});

  final int instructorId;
  final String token;

  @override
  List<Object> get props => [];
}

class GetCourseListRefresh extends CourseListEvent {
  const GetCourseListRefresh({required this.instructorId, required this.token});

  final int instructorId;
  final String token;

  @override
  List<Object> get props => [];
}

class GetCourseListUnsuccessful extends CourseListEvent {
  const GetCourseListUnsuccessful();

  @override
  List<Object> get props => [];
}
