import 'package:flutter/material.dart';

class InstructorDetails extends StatelessWidget {
  const InstructorDetails({Key? key}) : super(key: key);

  static const routeName = "/instructorDetails";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instructor Details')),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }
}
