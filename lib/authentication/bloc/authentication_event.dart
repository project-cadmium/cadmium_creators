part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationKeyChanged extends AuthenticationEvent {
  const AuthenticationKeyChanged(this.token);

  final AuthKey token;

  @override
  List<Object> get props => [token];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
