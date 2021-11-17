import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/components/components.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/details/bloc/get_bloc.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InstructorDetails extends StatelessWidget {
  const InstructorDetails({Key? key}) : super(key: key);

  static const routeName = "/instructorDetails";

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final User user = context.select(
        (AuthenticationBloc bloc) => bloc.state.user,
      );
      return _scaffold(context, user);
    });
  }

  Widget _scaffold(BuildContext context, User user) {
    final User user = context.select(
      (AuthenticationBloc bloc) => bloc.state.user,
    );
    final String token = context.select(
      (AuthenticationBloc bloc) => bloc.state.authKey.key,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Instructor Details')),
      drawer: NavigationDrawer(user: user),
      body: BlocProvider(
        create: (context) {
          return GetBloc(instructorRepository: InstructorRepository())
            ..add(GetInstructorInitial(userId: user.id, token: token));
        },
        child: BlocBuilder<GetBloc, GetState>(
          builder: (context, state) => _bodyWidget(context),
        ),
      ),
    );
  }
}

Widget _bodyWidget(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(15.0),
    child: SizedBox(
      width: double.infinity,
      child: _DetailsTable(),
    ),
  );
}

class _DetailsTable extends StatelessWidget {
  const _DetailsTable({Key? key}) : super(key: key);

  // TODO: Remove this
  final String sampleBiography = """
  # Hello
  Welcome to may channel sir *i* **am** said:
  > A gentleman can be whatever he want to be
  """;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text(
                "Biography",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Markdown(
                data: sampleBiography,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('EDIT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
