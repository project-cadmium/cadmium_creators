part of 'course_detail_bloc.dart';

abstract class CourseDetailEvent extends Equatable {
  const CourseDetailEvent();

  @override
  List<Object> get props => [];
}

class CourseDetailGetSuccessful extends CourseDetailEvent {
  const CourseDetailGetSuccessful(this.course);

  final Course course;

  @override
  List<Object> get props => [course];
}

class CourseDetailGetInitial extends CourseDetailEvent {
  const CourseDetailGetInitial({required this.courseId, required this.token});

  final int courseId;
  final String token;

  @override
  List<Object> get props => [];
}

class CourseDetailGetRefresh extends CourseDetailEvent {
  const CourseDetailGetRefresh({required this.courseId, required this.token});

  final int courseId;
  final String token;

  @override
  List<Object> get props => [];
}

class CourseDetailGetUnsuccessful extends CourseDetailEvent {
  const CourseDetailGetUnsuccessful();

  @override
  List<Object> get props => [];
}
