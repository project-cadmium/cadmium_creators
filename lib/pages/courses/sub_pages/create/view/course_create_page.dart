import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/courses/form_logic/form_logic.dart';
import 'package:cadmium_creators/pages/courses/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/details/bloc/get_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

class CourseCreatePage extends StatelessWidget {
  const CourseCreatePage({Key? key}) : super(key: key);

  static const routeName = '/courseCreate';

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final User user = context.select(
          (AuthenticationBloc bloc) => bloc.state.user,
        );
        final String token = context.select(
          (AuthenticationBloc bloc) => bloc.state.authKey.key,
        );
        return _scaffold(user, token);
      },
    );
  }

  Widget _scaffold(User user, String token) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Course")),
      body: _instructorBlocProvider(user, token),
    );
  }

  Widget _instructorBlocProvider(User user, String token) {
    return BlocProvider(
      create: (context) {
        return GetBloc(instructorRepository: InstructorRepository())
          ..add(GetInstructorInitial(userId: user.id, token: token));
      },
      child: BlocBuilder<GetBloc, GetState>(
        buildWhen: (previous, current) =>
            previous.instructor != current.instructor,
        builder: (context, state) {
          if (state.status == GetStatus.success) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                child: _CourseCreateBlocBuilder(
                  instructorId: state.instructor.id,
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _CourseCreateBlocBuilder extends StatelessWidget {
  const _CourseCreateBlocBuilder({Key? key, required this.instructorId})
      : super(key: key);

  final int instructorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CourseFormBloc(courseRepository: CourseRepository());
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
          child: _CourseCreateForm(instructorId: instructorId),
        ),
      ),
    );
  }
}

class _CourseCreateForm extends StatelessWidget {
  const _CourseCreateForm({Key? key, required this.instructorId})
      : super(key: key);

  final int instructorId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NameInput(),
        const SizedBox(height: 10),
        const _DescriptionInput(),
        const SizedBox(height: 10),
        _SubmitButton(instructorId: instructorId),
      ],
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFormBloc, CourseFormState>(
      buildWhen: (previous, current) =>
          previous.courseName != current.courseName,
      builder: (context, state) {
        return TextField(
          key: const Key('courseCreateFrom_nameInput_textField'),
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

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFormBloc, CourseFormState>(
      buildWhen: (previous, current) =>
          previous.courseDescription != current.courseDescription,
      builder: (context, state) {
        return TextField(
          key: const Key('courseCreateFrom_descriptionInput_textField'),
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
  const _SubmitButton({Key? key, required this.instructorId}) : super(key: key);
  final int instructorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFormBloc, CourseFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      key: const Key('courseCreateForm_register_raisedButton'),
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
                            CourseFormCreateSubmitted(
                              instructorId: instructorId,
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
