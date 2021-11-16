part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.authKey = AuthKey.empty,
  });

  final AuthenticationStatus status;
  final User user;
  final AuthKey authKey;

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(
      {required User user, required AuthKey authKey})
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          authKey: authKey,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
