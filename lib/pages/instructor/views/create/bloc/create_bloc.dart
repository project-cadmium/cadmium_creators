import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/create/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc({required InstructorRepository instructorRepository})
      : _instructorRepository = instructorRepository,
        super(const CreateState()) {
    on<CreateBiographyChanged>(_onBiographyChanged);
    on<CreateSubmitted>(_onCreateSubmitted);
  }

  final InstructorRepository _instructorRepository;

  void _onBiographyChanged(
      CreateBiographyChanged event, Emitter<CreateState> emit) {
    final biography = Biography.dirty(event.biography);
    emit(state.copyWith(
      biography: biography,
      status: Formz.validate([biography]),
    ));
  }

  void _onCreateSubmitted(
      CreateSubmitted event, Emitter<CreateState> emit) async {
    if (state.status.isValidated) {
      debugPrint(
          "_onCreateSubmitted: ${state.biography.value} ${event.userId} ${event.token}");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _instructorRepository.createInstructor(
          userId: event.userId,
          biography: state.biography.value,
          token: event.token,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        debugPrint("_onCreateSubmitted: ${e.toString()}");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
