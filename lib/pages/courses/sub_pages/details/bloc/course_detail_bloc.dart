import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/courses/repository/models/course.dart';
import 'package:equatable/equatable.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc() : super(const CourseDetailState.unknown()) {
    on<CourseDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
