import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/courses/form_logic/form_logic.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'course_form_event.dart';
part 'course_form_state.dart';

class CourseFormBloc extends Bloc<CourseFormEvent, CourseFormState> {
  CourseFormBloc() : super(const CourseFormState()) {
    on<CourseFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
