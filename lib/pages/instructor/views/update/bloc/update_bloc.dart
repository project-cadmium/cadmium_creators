import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/create/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc({required InstructorRepository instructorRepository})
      : _instructorRepository = instructorRepository,
        super(const UpdateState()) {
    on<UpdateBiographyChanged>(_onBiographyChanged);
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
}
