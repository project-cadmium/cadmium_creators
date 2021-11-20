part of 'course_list_bloc.dart';

abstract class CourseListState extends Equatable {
  const CourseListState();
  
  @override
  List<Object> get props => [];
}

class CourseListInitial extends CourseListState {}
