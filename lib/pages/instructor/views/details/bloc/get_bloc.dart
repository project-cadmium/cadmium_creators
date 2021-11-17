import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_event.dart';
part 'get_state.dart';

class GetBloc extends Bloc<GetEvent, GetState> {
  GetBloc({required InstructorRepository instructorRepository})
      : _instructorRepository = instructorRepository,
        super(const GetState.unknown()) {
    on<GetInstructorInitial>(_onInitialEvent);
    on<GetInstructorSuccessful>(_onGettingSuccessful);
    on<GetInstructorUnsuccessful>(_onGettingUnsuccessful);
  }

  final InstructorRepository _instructorRepository;

  void _onInitialEvent(
      GetInstructorInitial event, Emitter<GetState> emit) async {
    debugPrint("_onInitialEvent fired");
    try {
      final Instructor? instructor = await _instructorRepository.getInstructor(
          userId: event.userId, token: event.token);
      debugPrint("_onInitialEvent $instructor");
      add(GetInstructorSuccessful(instructor!));
    } catch (e) {
      debugPrint("_onInitialEvent: ${e.toString()}");
      add(const GetInstructorUnsuccessful());
    }
  }

  void _onGettingSuccessful(
      GetInstructorSuccessful event, Emitter<GetState> emit) {
    emit(GetState.success(event.instructor));
  }

  void _onGettingUnsuccessful(
      GetInstructorUnsuccessful event, Emitter<GetState> emit) {
    // TODO: Do sth
  }
}
