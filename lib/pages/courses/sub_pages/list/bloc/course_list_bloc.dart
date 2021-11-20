import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/courses/courses.dart';
import 'package:equatable/equatable.dart';

part 'course_list_event.dart';
part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc() : super(const CourseListState.unknown()) {
    on<CourseListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
