import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// TODO: rename to AuthenticationStreamStatus
class AuthStreamData {
  AuthStreamData({required this.status});

  final AuthenticationStatus status;
  AuthKey? authKey;

  AuthStreamData.unknown() : status = AuthenticationStatus.unknown;
  AuthStreamData.authenticated(this.authKey)
      : status = AuthenticationStatus.authenticated;
  AuthStreamData.unauthenticated()
      : status = AuthenticationStatus.unauthenticated;
}

class AuthKey {
  const AuthKey({required this.key});
  final String key;

  static const empty = AuthKey(key: "empty");

  factory AuthKey.fromJson(Map<String, dynamic> json) {
    return AuthKey(
      key: json["key"],
    );
  }
}

class AuthenticationRepository {
  final _controller = StreamController<AuthStreamData>();
  final _authKeyController = StreamController<AuthKey>();

  Stream<AuthStreamData> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield AuthStreamData.unauthenticated();
    yield* _controller.stream;
  }

  Stream<AuthKey> get token async* {
    yield AuthKey.empty;
    yield* _authKeyController.stream;
  }

  Future<void> logIn(
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
      _authKeyController.add(authKey);
      _controller.add(AuthStreamData.authenticated(authKey));
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }

  void logOut() {
    _controller.add(AuthStreamData.unauthenticated());
  }

  void dispose() {
    _controller.close();
    _authKeyController.close();
  }
}
