import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/courses/form_logic/form_logic.dart';
import 'package:cadmium_creators/pages/courses/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'course_form_event.dart';
part 'course_form_state.dart';

class CourseFormBloc extends Bloc<CourseFormEvent, CourseFormState> {
  CourseFormBloc({required CourseRepository courseRepository})
      : _courseRepository = courseRepository,
        super(const CourseFormState()) {
    on<CourseFormNameChanged>(_onNameChanged);
    on<CourseFormDescriptionChanged>(_onDescriptionChanged);
    on<CourseFormCreateSubmitted>(_onCreateSubmitted);
    on<CourseFormUpdateInitial>(_onUpdateInitialState);
    on<CourseFormUpdateSubmitted>(_onUpdateSubmitted);
  }

  final CourseRepository _courseRepository;

  void _onNameChanged(
      CourseFormNameChanged event, Emitter<CourseFormState> emit) {
    final name = CourseName.dirty(event.name);
    emit(state.copyWith(
      courseName: name,
      status: Formz.validate([name, state.courseDescription]),
    ));
  }

  void _onDescriptionChanged(
      CourseFormDescriptionChanged event, Emitter<CourseFormState> emit) {
    final description = CourseDescription.dirty(event.description);
    emit(state.copyWith(
      courseDescription: description,
      status: Formz.validate([description, state.courseName]),
    ));
  }

  void _onCreateSubmitted(
      CourseFormCreateSubmitted event, Emitter<CourseFormState> emit) async {
    if (state.status.isValidated) {
      debugPrint(
          "\nCourseFormBloc._onUpdateSubmitted: ${event.instructorId} ${event.token}");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _courseRepository.createCourse(
          instructorId: event.instructorId,
          name: state.courseName.value,
          description: state.courseDescription.value,
          token: event.token,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        debugPrint("\nCourseFormBloc._onUpdateSubmitted:: ${e.toString()}");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onUpdateInitialState(
      CourseFormUpdateInitial event, Emitter<CourseFormState> emit) {
    final name = CourseName.dirty(event.name);
    final description = CourseDescription.dirty(event.description);
    emit(state.copyWith(
      courseName: name,
      courseDescription: description,
      status: Formz.validate([name, description]),
    ));
  }

  void _onUpdateSubmitted(
      CourseFormUpdateSubmitted event, Emitter<CourseFormState> emit) async {
    if (state.status.isValidated) {
      debugPrint(
          "\nCourseFormBloc._onUpdateSubmitted: ${event.courseId} ${event.token}");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _courseRepository.updateCourse(
          courseId: event.courseId,
          instructorId: event.instructorId,
          name: state.courseName.value,
          description: state.courseDescription.value,
          token: event.token,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        debugPrint("\nCourseFormBloc._onUpdateSubmitted:: ${e.toString()}");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
