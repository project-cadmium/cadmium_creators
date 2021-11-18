import 'package:bloc/bloc.dart';
import 'package:cadmium_creators/pages/instructor/views/create/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(const UpdateState()) {
    on<UpdateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
