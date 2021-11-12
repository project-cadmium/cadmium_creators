import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn(
      {required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/v1/auth/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': 'aberry',
        'password': 'password',
      }),
    );

    print(response.statusCode);
    print(response.body);

    await Future.delayed(
      const Duration(seconds: 3),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
