part of 'course_form_bloc.dart';

class CourseFormState extends Equatable {
  const CourseFormState({
    this.status = FormzStatus.pure,
    this.courseName = const CourseName.pure(),
    this.courseDescription = const CourseDescription.pure(),
  });

  final FormzStatus status;
  final CourseName courseName;
  final CourseDescription courseDescription;

  CourseFormState copyWith({
    FormzStatus? status,
    CourseName? courseName,
    CourseDescription? courseDescription,
  }) {
    return CourseFormState(
      status: status ?? this.status,
      courseName: courseName ?? this.courseName,
      courseDescription: courseDescription ?? this.courseDescription,
    );
  }

  @override
  List<Object> get props => [status, courseName, courseDescription];
}
