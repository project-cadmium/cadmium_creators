import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/courses/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc({required CourseRepository courseRepository})
      : _courseRepository = courseRepository,
        super(const CourseDetailState.unknown()) {
    on<CourseDetailGetInitial>(_onInitialEvent);
    on<CourseDetailGetRefresh>(_onRefreshEvent);
    on<CourseDetailGetSuccessful>(_onGettingSuccessful);
    on<CourseDetailGetUnsuccessful>(_onGettingUnsuccessful);
  }

  final CourseRepository _courseRepository;

  void _onInitialEvent(
      CourseDetailGetInitial event, Emitter<CourseDetailState> emit) async {
    debugPrint("\n\nCourseDetailBloc._onInitialEvent fired");
    try {
      final Course? course = await _courseRepository.getCourse(
          courseId: event.courseId, token: event.token);
      debugPrint("CourseDetailBloc._onInitialEvent $course");
      add(CourseDetailGetSuccessful(course!));
    } catch (e) {
      debugPrint("CourseDetailBloc._onInitialEvent: ${e.toString()}");
      add(const CourseDetailGetUnsuccessful());
    }
  }

  void _onRefreshEvent(
      CourseDetailGetRefresh event, Emitter<CourseDetailState> emit) async {
    emit(const CourseDetailState.unknown());
    debugPrint("\n\nCourseDetailBloc._onRefreshEvent fired");
    try {
      final Course? course = await _courseRepository.getCourse(
          courseId: event.courseId, token: event.token);
      debugPrint("CourseDetailBloc._onRefreshEvent $course");
      add(CourseDetailGetSuccessful(course!));
    } catch (e) {
      debugPrint("CourseDetailBloc._onRefreshEvent: ${e.toString()}");
      add(const CourseDetailGetUnsuccessful());
    }
  }

  void _onGettingSuccessful(
      CourseDetailGetSuccessful event, Emitter<CourseDetailState> emit) {
    emit(CourseDetailState.success(event.course));
  }

  void _onGettingUnsuccessful(
      CourseDetailGetUnsuccessful event, Emitter<CourseDetailState> emit) {
    // TODO: Do sth
  }
}
