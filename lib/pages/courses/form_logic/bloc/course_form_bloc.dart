import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'course_form_event.dart';
part 'course_form_state.dart';

class CourseFormBloc extends Bloc<CourseFormEvent, CourseFormState> {
  CourseFormBloc() : super(CourseFormInitial()) {
    on<CourseFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
