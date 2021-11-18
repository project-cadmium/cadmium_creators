part of 'get_bloc.dart';

enum GetStatus { unknown, success, error }

class GetState extends Equatable {
  const GetState._({
    this.status = GetStatus.unknown,
    this.instructor = Instructor.empty,
  });

  final GetStatus status;
  final Instructor instructor;

  const GetState.unknown() : this._();

  const GetState.success(Instructor instructor)
      : this._(
          status: GetStatus.success,
          instructor: instructor,
        );

  // TODO: Respond to this in the UI
  const GetState.error() : this._(status: GetStatus.error);

  @override
  List<Object> get props => [status, instructor];
}
