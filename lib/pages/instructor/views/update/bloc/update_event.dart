part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateBiographyChanged extends UpdateEvent {
  const UpdateBiographyChanged(this.biography);

  final String biography;

  @override
  List<Object> get props => [biography];
}

class UpdateSubmitted extends UpdateEvent {
  const UpdateSubmitted({required this.userId, required this.token});

  final int userId;
  final String token;

  @override
  List<Object> get props => [userId, token];
}
