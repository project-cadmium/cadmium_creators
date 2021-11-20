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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: _CourseUpdateForm(course: course),
          ),
        ),
      ),
    );
  }
}

class _CourseUpdateForm extends StatelessWidget {
  const _CourseUpdateForm({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          key: Key('courseUpdateFrom_nameInput_textField'),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
        ),
        const SizedBox(height: 10),
        _DescriptionInput(description: course.description),
        const SizedBox(height: 10),
        const _SubmitButtton(),
      ],
    );
  }
}

class _DescriptionInput extends StatefulWidget {
  const _DescriptionInput({Key? key, required this.description})
      : super(key: key);
  final String description;
  @override
  _DescriptionInputState createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<_DescriptionInput> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      key: const Key('courseUpdateFrom_descriptionInput_textField'),
      minLines: 4,
      maxLines: 20,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description',
      ),
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
