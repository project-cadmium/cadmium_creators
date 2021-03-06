import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/instructor/views/create/bloc/create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateBloc, CreateState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Could not register you.')),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('You are now an instructor!')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Enter your biography to register',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            _BiographyInput(),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class _BiographyInput extends StatelessWidget {
  const _BiographyInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBloc, CreateState>(
      buildWhen: (previous, current) => previous.biography != current.biography,
      builder: (context, state) {
        return TextField(
          key: const Key('registrationForm_biographyInput_textField'),
          minLines: 4,
          maxLines: 10,
          onChanged: (value) =>
              context.read<CreateBloc>().add(CreateBiographyChanged(value)),
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

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBloc, CreateState>(
      buildWhen: (previous, current) => previous.status != current.status,
      key: const Key('biographyForm_register_raisedButton'),
      builder: (context, state) {
        final User user = context.select(
          (AuthenticationBloc bloc) => bloc.state.user,
        );
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
                      context.read<CreateBloc>().add(
                            CreateSubmitted(
                              userId: user.id,
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
              : const Text('Register'),
        );
      },
    );
  }
}
