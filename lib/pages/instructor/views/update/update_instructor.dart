import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/details/bloc/get_bloc.dart';
import 'package:cadmium_creators/pages/instructor/views/update/bloc/update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateInstructor extends StatelessWidget {
  const UpdateInstructor({Key? key}) : super(key: key);

  static const routeName = "/updateInstructor";

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final User user = context.select(
        (AuthenticationBloc bloc) => bloc.state.user,
      );
      final String token = context.select(
        (AuthenticationBloc bloc) => bloc.state.authKey.key,
      );
      return _scaffold(user, token);
    });
  }

  Widget _scaffold(user, token) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Instructor')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: BlocProvider(
          create: (context) {
            return GetBloc(instructorRepository: InstructorRepository())
              ..add(GetInstructorInitial(userId: user.id, token: token));
          },
          child: BlocBuilder<GetBloc, GetState>(
            builder: (context, state) {
              if (state.status == GetStatus.success) {
                return _UpdateInstructorBlocBuilder(
                  instructor: state.instructor,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _UpdateInstructorBlocBuilder extends StatelessWidget {
  const _UpdateInstructorBlocBuilder({Key? key, required this.instructor})
      : super(key: key);

  final Instructor instructor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UpdateBloc(instructorRepository: InstructorRepository())
          ..add(UpdateBiographyChanged(instructor.biography));
      },
      child: _UpdateInstructorForm(instructor: instructor),
    );
  }
}

class _UpdateInstructorForm extends StatelessWidget {
  const _UpdateInstructorForm({Key? key, required this.instructor})
      : super(key: key);

  final Instructor instructor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your biography',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        _BiographyInput(
          instructor: instructor,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        const _SubmitButton(),
      ],
    );
  }
}

class _BiographyInput extends StatefulWidget {
  const _BiographyInput({Key? key, required this.instructor}) : super(key: key);

  final Instructor instructor;

  @override
  _BiographyInputState createState() => _BiographyInputState();
}

class _BiographyInputState extends State<_BiographyInput> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: widget.instructor.biography);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      buildWhen: (previous, current) => previous.biography != current.biography,
      builder: (context, state) {
        return TextField(
          controller: _controller,
          key: const Key('registrationForm_biographyInput_textField'),
          minLines: 4,
          maxLines: 10,
          onChanged: (value) =>
              context.read<UpdateBloc>().add(UpdateBiographyChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Biography',
            errorText: state.biography.invalid ? 'invalid biography' : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

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
      child: const Text('Save'),
    );
  }
}
