import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser(String token) async {
    if (_user != null) return _user;

    print("Token $token");

    final response = await http.get(
      Uri.parse('http://localhost:8000/api/v1/auth/user/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      _user = User.fromJson(jsonDecode(response.body));
      return _user;
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }
}
