part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class CreateBiographyChanged extends CreateEvent {
  const CreateBiographyChanged(this.biography);

  final String biography;

  @override
  List<Object> get props => [biography];
}

class CreateSubmitted extends CreateEvent {
  const CreateSubmitted();
}
