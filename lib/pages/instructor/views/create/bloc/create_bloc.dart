import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/views/create/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(const CreateState()) {
    on<CreateBiographyChanged>(_onBiographyChanged);
  }

  void _onBiographyChanged(
      CreateBiographyChanged event, Emitter<CreateState> emit) {
    final biography = Biography.dirty(event.biography);
    emit(state.copyWith(
      biography: biography,
      status: Formz.validate([biography]),
    ));
  }
}
