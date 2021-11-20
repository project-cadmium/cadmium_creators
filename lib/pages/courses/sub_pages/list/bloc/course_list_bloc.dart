import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/courses/courses.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'course_list_event.dart';
part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc({required CourseRepository courseRepository})
      : _courseRepository = courseRepository,
        super(const CourseListState.unknown()) {
    on<GetCourseListInitial>(_onInitialEvent);
    on<GetCourseListRefresh>(_onRefreshEvent);
    on<GetCourseListSuccessful>(_onGettingSuccessful);
    on<GetCourseListUnsuccessful>(_onGettingUnsuccessful);
  }

  final CourseRepository _courseRepository;

  void _onInitialEvent(
      GetCourseListInitial event, Emitter<CourseListState> emit) async {
    debugPrint("CourseListBloc._onInitialEvent fired: ${event.instructorId}");
    try {
      final List<Course>? courses = await _courseRepository.getCourses(
          instructorId: event.instructorId, token: event.token);
      debugPrint("CourseListBloc._onInitialEvent $courses");
      add(GetCourseListSuccessful(courses!));
    } catch (e) {
      debugPrint("CourseListBloc._onInitialEvent: ${e.toString()}");
      add(const GetCourseListUnsuccessful());
    }
  }

  void _onRefreshEvent(
      GetCourseListRefresh event, Emitter<CourseListState> emit) async {
    emit(const CourseListState.unknown());
    debugPrint("\nCourseListBloc._onRefreshEvent fired: ${event.instructorId}");
    try {
      final List<Course>? courses = await _courseRepository.getCourses(
          instructorId: event.instructorId, token: event.token);
      debugPrint("CourseListBloc._onRefreshEvent $courses");
      add(GetCourseListSuccessful(courses!));
    } catch (e) {
      debugPrint("CourseListBloc._onRefreshEvent: ${e.toString()}");
      add(const GetCourseListUnsuccessful());
    }
  }

  void _onGettingSuccessful(
      GetCourseListSuccessful event, Emitter<CourseListState> emit) {
    emit(CourseListState.success(event.courses));
  }

  void _onGettingUnsuccessful(
      GetCourseListUnsuccessful event, Emitter<CourseListState> emit) {
    // TODO: Do sth
  }
}
