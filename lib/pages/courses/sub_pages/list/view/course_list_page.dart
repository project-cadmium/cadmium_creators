import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/components/components.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/details/bloc/get_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({Key? key}) : super(key: key);

  static const routeName = '/courseList';

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

  Widget _scaffold(User user, String token) {
    return Scaffold(
        appBar: AppBar(title: const Text('Courses')),
        drawer: NavigationDrawer(user: user),
        body: _instructorBlocProvider(user, token));
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
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
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
