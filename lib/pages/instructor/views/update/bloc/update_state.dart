part of 'update_bloc.dart';

class UpdateState extends Equatable {
  const UpdateState({
    this.status = FormzStatus.pure,
    this.biography = const Biography.pure(),
  });

  final FormzStatus status;
  final Biography biography;

  UpdateState copyWith({
    FormzStatus? status,
    Biography? biography,
  }) {
    return UpdateState(
      status: status ?? this.status,
      biography: biography ?? this.biography,
    );
  }

  @override
  List<Object> get props => [status, biography];
}
