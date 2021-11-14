import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthKey {
  final String key;
  AuthKey({required this.key});

  factory AuthKey.fromJson(Map<String, dynamic> json) {
    return AuthKey(
      key: json["key"],
    );
  }
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<String?> logIn(
      {required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/v1/auth/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final AuthKey authKey = AuthKey.fromJson(jsonDecode(response.body));
      _controller.add(AuthenticationStatus.authenticated);
      print(authKey.key);
      return authKey.key;
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
