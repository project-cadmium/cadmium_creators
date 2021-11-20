import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/courses/repository/repository.dart';
import 'package:cadmium_creators/pages/courses/sub_pages/details/bloc/course_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseUpdatePage extends StatelessWidget {
  const CourseUpdatePage({Key? key}) : super(key: key);

  static const routeName = '/courseUpdate';

  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as Course;
    final String token = context.select(
      (AuthenticationBloc bloc) => bloc.state.authKey.key,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Update Course")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Card(
          child: BlocProvider(create: (context) {
            return CourseDetailBloc(courseRepository: CourseRepository())
              ..add(CourseDetailGetInitial(courseId: course.id, token: token));
          }, child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
              builder: (context, state) {
            if (state.status == CourseDetailGetStatus.success) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: _CourseUpdateForm(course: state.course),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
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
        _NameInput(name: course.name),
        const SizedBox(height: 10),
        _DescriptionInput(description: course.description),
        const SizedBox(height: 10),
        const _SubmitButtton(),
      ],
    );
  }
}

class _NameInput extends StatefulWidget {
  const _NameInput({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  _NameInputState createState() => _NameInputState();
}

class _NameInputState extends State<_NameInput> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      key: const Key('courseUpdateFrom_nameInput_textField'),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
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
