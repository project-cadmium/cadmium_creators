import 'package:flutter/material.dart';

class CourseCreatePage extends StatelessWidget {
  const CourseCreatePage({Key? key}) : super(key: key);

  static const routeName = '/courseCreate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Course")),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }
}
