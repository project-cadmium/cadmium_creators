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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: _CourseUpdateForm(),
          ),
        ),
      ),
    );
  }
}

class _CourseUpdateForm extends StatelessWidget {
  const _CourseUpdateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TextField(
          key: Key('courseUpdateFrom_nameInput_textField'),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          key: Key('courseUpdateFrom_descriptionInput_textField'),
          minLines: 4,
          maxLines: 20,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description',
          ),
        ),
        SizedBox(height: 10),
        _SubmitButtton(),
      ],
    );
  }
}

class _SubmitButtton extends StatelessWidget {
  const _SubmitButtton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          double.minPositive,
          40,
        ), // double.infinity is the width and 30 is the height
      ),
      onPressed: () {},
      child: const Text("Save"),
    );
  }
}
