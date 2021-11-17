import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/components/components.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Instructor Details')),
      drawer: NavigationDrawer(user: user),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: SizedBox(
          width: double.infinity,
          child: _DetailsTable(),
        ),
      ),
    );
  }
}

class _DetailsTable extends StatelessWidget {
  const _DetailsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              child: Text(
                "Biography",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 6, 5, 10),
              child: Text("Hello gentlemen"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('EDIT'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                minimumSize: const Size(
                  30,
                  30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
