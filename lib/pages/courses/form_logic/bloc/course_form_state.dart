part of 'course_form_bloc.dart';

abstract class CourseFormState extends Equatable {
  const CourseFormState();
  
  @override
  List<Object> get props => [];
}

class CourseFormInitial extends CourseFormState {}
