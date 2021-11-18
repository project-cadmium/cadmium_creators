import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/create/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc({required InstructorRepository instructorRepository})
      : _instructorRepository = instructorRepository,
        super(const UpdateState()) {
    on<UpdateBiographyChanged>(_onBiographyChanged);
    on<UpdateSubmitted>(_onUpdateSubmitted);
  }

  final InstructorRepository _instructorRepository;

  void _onBiographyChanged(
      UpdateBiographyChanged event, Emitter<UpdateState> emit) {
    final biography = Biography.dirty(event.biography);
    emit(state.copyWith(
      biography: biography,
      status: Formz.validate([biography]),
    ));
  }

  void _onUpdateSubmitted(
      UpdateSubmitted event, Emitter<UpdateState> emit) async {
    if (state.status.isValidated) {
      debugPrint(
          "_onUpdateSubmitted: ${state.biography.value} ${event.userId} ${event.token}");
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _instructorRepository.updateInstructor(
          userId: event.userId,
          biography: state.biography.value,
          token: event.token,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        debugPrint("_onUpdateSubmitted: ${e.toString()}");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
