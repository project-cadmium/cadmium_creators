import 'package:flutter/material.dart';

class RegisterInstructor extends StatelessWidget {
  const RegisterInstructor({Key? key}) : super(key: key);

  static const routeName = "registerInstructor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register as Instructor')),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }
}
