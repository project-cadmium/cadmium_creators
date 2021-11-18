import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/details/bloc/get_bloc.dart';
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
                return const _UpdateInstructorForm();
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

class _UpdateInstructorForm extends StatelessWidget {
  const _UpdateInstructorForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Your biography',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        _BiographyInput(),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        _SubmitButton(),
      ],
    );
  }
}

class _BiographyInput extends StatelessWidget {
  const _BiographyInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      key: Key('registrationForm_biographyInput_textField'),
      minLines: 4,
      maxLines: 10,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Biography',
        // errorText: state.biography.invalid ? 'invalid biography' : null,
      ),
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
      child: const Text('Update'),
    );
  }
}
