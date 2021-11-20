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
          'http://localhost:8000/api/v1/courses/?ordering=name&instructor_id=$instructorId'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      debugPrint("getCourses ${response.body}");
      final List<dynamic> courseMapList = jsonDecode(response.body);

      List<Course> courseList = [];
      for (Map<String, dynamic> course in courseMapList) {
        courseList.add(Course(
          id: course['id'],
          instructorId: course['instructor_id'],
          name: course['name'],
          description: course['description'],
          createdAt: course['created_at'],
          updatedAt: course['updated_at'],
        ));
      }

      return courseList;
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }

  Future<Course?> getCourse(
      {required int courseId, required String token}) async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/v1/courses/$courseId/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      final Course course = Course.fromJson(jsonDecode(response.body));
      return course;
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }

  Future<void> updateCourse({
    required int courseId,
    required int instructorId,
    required String name,
    required String description,
    required String token,
  }) async {
    final response = await http.put(
      Uri.parse('http://localhost:8000/api/v1/courses/$courseId/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token',
      },
      body: jsonEncode(<String, dynamic>{
        'instructor_id': instructorId,
        'name': name,
        'description': description,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint('\nCoursesRepository.updateCourse success ${response.body}');
    } else {
      throw Exception("${response.statusCode} ${response.body} ");
    }
  }
}
