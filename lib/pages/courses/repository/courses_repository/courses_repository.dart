import 'dart:convert';
import 'dart:io';

import 'package:cadmium_creators/pages/courses/courses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  Future<List<Course>?> getCourses(
      {required int instructorId, required String token}) async {
    final response = await http.get(
      Uri.parse(
          'http://localhost:8000/api/v1/courses/?instructor_id=$instructorId'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      debugPrint("getCourses ${response.body}");
      final List<String> courseStringList = jsonDecode(response.body);
      List<Course> courseList = [];
      for (String instructor in courseStringList) {
        courseList.add(Course.fromJson(jsonDecode(instructor)));
      }
      debugPrint("getCourses $courseList");
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }
}
