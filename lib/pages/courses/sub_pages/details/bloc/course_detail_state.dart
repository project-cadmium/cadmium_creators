part of 'course_detail_bloc.dart';

enum CourseDetailGetStatus { unknown, success, error }

class CourseDetailState extends Equatable {
  const CourseDetailState._({
    this.status = CourseDetailGetStatus.unknown,
    this.course = Course.empty,
  });

  final CourseDetailGetStatus status;
  final Course course;

  const CourseDetailState.unknown() : this._();

  const CourseDetailState.success(Course course)
      : this._(
          status: CourseDetailGetStatus.success,
          course: course,
        );

  // TODO: Respond to this in the UI
  const CourseDetailState.error() : this._(status: CourseDetailGetStatus.error);

  @override
  List<Object> get props => [status, course];
}
