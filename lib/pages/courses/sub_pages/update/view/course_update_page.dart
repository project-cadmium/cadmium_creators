import 'package:cadmium_creators/pages/courses/repository/repository.dart';
import 'package:flutter/material.dart';

class CourseUpdatePage extends StatelessWidget {
  const CourseUpdatePage({Key? key}) : super(key: key);

  static const routeName = '/courseUpdate';

  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as Course;

    return Scaffold(
      appBar: AppBar(title: const Text("Update Course")),
      body: Text("Holla ${course.name}"),
    );
  }
}
