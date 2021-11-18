import 'package:flutter/material.dart';

class UpdateInstructor extends StatelessWidget {
  const UpdateInstructor({Key? key}) : super(key: key);

  static const routeName = "/updateInstructor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Instructor')),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }
}
