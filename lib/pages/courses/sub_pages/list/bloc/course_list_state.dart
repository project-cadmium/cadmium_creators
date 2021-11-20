part of 'course_list_bloc.dart';

enum CourseListGetStatus { unknown, success, error }

class CourseListState extends Equatable {
  const CourseListState._({
    this.status = CourseListGetStatus.unknown,
    this.course = Course.empty,
  });

  final CourseListGetStatus status;
  final Course course;

  const CourseListState.unknown() : this._();

  const CourseListState.success(Course course)
      : this._(
          status: CourseListGetStatus.success,
          course: course,
        );

  // TODO: Respond to this in the UI
  const CourseListState.error() : this._(status: CourseListGetStatus.error);

  @override
  List<Object> get props => [status, course];
}
