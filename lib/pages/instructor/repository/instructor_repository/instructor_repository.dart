import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class InstructorRepository {
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
    if (response.statusCode == 201) {
      debugPrint('createInstructor success ${response.body}');
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }

  Future<Instructor?> getInstructor(
      {required int userId, required String token}) async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/v1/instructors/${userId}/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      return Instructor.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }
}
