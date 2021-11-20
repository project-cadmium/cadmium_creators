import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/courses/form_logic/form_logic.dart';
import 'package:cadmium_creators/pages/courses/repository/repository.dart';
import 'package:cadmium_creators/pages/courses/sub_pages/details/bloc/course_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
              return _CourseUpdateBlocBuilder(course: state.course);
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

class _CourseUpdateBlocBuilder extends StatelessWidget {
  const _CourseUpdateBlocBuilder({Key? key, required this.course})
      : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CourseFormBloc(courseRepository: CourseRepository())
          ..add(CourseFormUpdateInitial(
              name: course.name, description: course.description));
      },
      child: BlocListener<CourseFormBloc, CourseFormState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Could not save changes.')),
              );
          } else if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Changes saved successfully.')),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: _CourseUpdateForm(course: course),
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
        _SubmitButton(courseId: course.id),
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
    return BlocBuilder<CourseFormBloc, CourseFormState>(
      buildWhen: (previous, current) =>
          previous.courseName != current.courseName,
      builder: (context, state) {
        return TextField(
          controller: _controller,
          key: const Key('courseUpdateFrom_nameInput_textField'),
          onChanged: (value) =>
              context.read<CourseFormBloc>().add(CourseFormNameChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Name',
            errorText: state.courseName.invalid ? 'invalid name' : null,
          ),
        );
      },
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
    return BlocBuilder<CourseFormBloc, CourseFormState>(
      buildWhen: (previous, current) =>
          previous.courseDescription != current.courseDescription,
      builder: (context, state) {
        return TextField(
          controller: _controller,
          key: const Key('courseUpdateFrom_descriptionInput_textField'),
          minLines: 4,
          maxLines: 20,
          onChanged: (value) => context
              .read<CourseFormBloc>()
              .add(CourseFormDescriptionChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Description',
            errorText:
                state.courseDescription.invalid ? 'invalid description' : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key, required this.courseId}) : super(key: key);
  final int courseId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFormBloc, CourseFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      key: const Key('courseUpdateForm_register_raisedButton'),
      builder: (context, state) {
        final String token = context.select(
          (AuthenticationBloc bloc) => bloc.state.authKey.key,
        );
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(
              double.minPositive,
              40,
            ), // double.infinity is the width and 30 is the height
          ),
          onPressed:
              !state.status.isSubmissionInProgress && state.status.isValidated
                  ? () {
                      context.read<CourseFormBloc>().add(
                            CourseFormUpdateSubmitted(
                              courseId: courseId,
                              token: token,
                            ),
                          );
                    }
                  : null,
          child: state.status.isSubmissionInProgress
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                )
              : const Text('Save'),
        );
      },
    );
  }
}
