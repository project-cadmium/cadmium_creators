part of 'get_bloc.dart';

enum GetStatus { unknown, success, error }

class GetState extends Equatable {
  const GetState({
    this.status = GetStatus.unknown,
    this.instructor = Instructor.empty,
  });

  final GetStatus status;
  final Instructor instructor;

  @override
  List<Object> get props => [];
}

class GetInitial extends GetState {}
