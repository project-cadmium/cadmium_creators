import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class InstructorRepository {
  Instructor? _instructor;

  Future<void> createInstructor({
    required int userId,
    required String biography,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/v1/instructors/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'biography': biography,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint('createInstructor success ${response.body}');
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }
}
