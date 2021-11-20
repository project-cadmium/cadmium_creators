import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/courses/form_logic/form_logic.dart';
import 'package:cadmium_creators/pages/courses/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'course_form_event.dart';
part 'course_form_state.dart';

class CourseFormBloc extends Bloc<CourseFormEvent, CourseFormState> {
  CourseFormBloc({required CourseRepository courseRepository})
      : _courseRepository = courseRepository,
        super(const CourseFormState()) {
    on<CourseFormNameChanged>(_onNameChanged);
    on<CourseFormDescriptionChanged>(_onDescriptionChanged);
    on<CourseFormUpdateInitial>(_onUpdateInitialState);
  }

  final CourseRepository _courseRepository;

  void _onNameChanged(
      CourseFormNameChanged event, Emitter<CourseFormState> emit) {
    final name = CourseName.dirty(event.name);
    emit(state.copyWith(
      courseName: name,
      status: Formz.validate([name]),
    ));
  }

  void _onDescriptionChanged(
      CourseFormDescriptionChanged event, Emitter<CourseFormState> emit) {
    final description = CourseDescription.dirty(event.description);
    emit(state.copyWith(
      courseDescription: description,
      status: Formz.validate([description]),
    ));
  }

  void _onUpdateInitialState(
      CourseFormUpdateInitial event, Emitter<CourseFormState> emit) {
    final name = CourseName.dirty(event.name);
    final description = CourseName.dirty(event.description);
    emit(state.copyWith(
      courseName: name,
      status: Formz.validate([name, description]),
    ));
  }
}
