part of 'course_detail_bloc.dart';

abstract class CourseDetailState extends Equatable {
  const CourseDetailState();
  
  @override
  List<Object> get props => [];
}

class CourseDetailInitial extends CourseDetailState {}
