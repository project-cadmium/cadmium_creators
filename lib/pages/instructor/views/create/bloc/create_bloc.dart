import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/views/create/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(const CreateState()) {
    on<CreateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
