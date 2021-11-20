part of 'course_list_bloc.dart';

enum CourseListGetStatus { unknown, success, error }

class CourseListState extends Equatable {
  const CourseListState._({
    this.status = CourseListGetStatus.unknown,
    this.courses = const [],
  });

  final CourseListGetStatus status;
  final List<Course> courses;

  const CourseListState.unknown() : this._();

  const CourseListState.success(List<Course> courses)
      : this._(
          status: CourseListGetStatus.success,
          courses: courses,
        );

  // TODO: Respond to this in the UI
  const CourseListState.error() : this._(status: CourseListGetStatus.error);

  @override
  List<Object> get props => [status, courses];
}
