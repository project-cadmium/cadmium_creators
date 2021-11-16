part of 'create_bloc.dart';

class CreateState extends Equatable {
  const CreateState({
    this.status = FormzStatus.pure,
    this.biography = const Biography.pure(),
  });

  final FormzStatus status;
  final Biography biography;

  CreateState copyWith({
    FormzStatus? status,
    Biography? biography,
  }) {
    return CreateState(
      status: status ?? this.status,
      biography: biography ?? this.biography,
    );
  }

  @override
  List<Object> get props => [status, biography];
}
