import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/views/create/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(const CreateState()) {
    on<CreateBiographyChanged>(_onBiographyChanged);
    on<CreateSubmitted>(_onCreateSubmitted);
  }

  void _onBiographyChanged(
      CreateBiographyChanged event, Emitter<CreateState> emit) {
    final biography = Biography.dirty(event.biography);
    emit(state.copyWith(
      biography: biography,
      status: Formz.validate([biography]),
    ));
  }

  void _onCreateSubmitted(CreateSubmitted event, Emitter<CreateState> emit) {
    if (state.status.isValidated) {
      debugPrint(state.biography.value);
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
