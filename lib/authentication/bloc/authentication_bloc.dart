import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationKeyChanged>(_onAuthenticationKeyChanged);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
    _authKeySubscription = _authenticationRepository.token.listen(
      (token) => add(AuthenticationKeyChanged(token)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  late StreamSubscription<AuthKey> _authKeySubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authKeySubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  void _onAuthenticationKeyChanged(
      AuthenticationKeyChanged event, Emitter<AuthenticationState> emit) {
    if (event.token.key != AuthKey.empty) {
      debugPrint("authentication_bloc ${event.token.key}");
    }
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        debugPrint("getting user");
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }
}
