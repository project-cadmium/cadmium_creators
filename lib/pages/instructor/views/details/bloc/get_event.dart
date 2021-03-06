part of 'get_bloc.dart';

abstract class GetEvent extends Equatable {
  const GetEvent();

  @override
  List<Object> get props => [];
}

class GetInstructorSuccessful extends GetEvent {
  const GetInstructorSuccessful(this.instructor);

  final Instructor instructor;

  @override
  List<Object> get props => [instructor];
}

class GetInstructorInitial extends GetEvent {
  const GetInstructorInitial({required this.userId, required this.token});

  final int userId;
  final String token;

  @override
  List<Object> get props => [];
}

class GetInstructorRefresh extends GetEvent {
  const GetInstructorRefresh({required this.userId, required this.token});

  final int userId;
  final String token;

  @override
  List<Object> get props => [];
}

class GetInstructorUnsuccessful extends GetEvent {
  const GetInstructorUnsuccessful();

  @override
  List<Object> get props => [];
}
