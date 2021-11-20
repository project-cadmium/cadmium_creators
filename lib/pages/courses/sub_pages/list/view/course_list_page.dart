import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/components/components.dart';
import 'package:cadmium_creators/pages/courses/sub_pages/list/bloc/course_list_bloc.dart';
import 'package:cadmium_creators/pages/instructor/repository/repository.dart';
import 'package:cadmium_creators/pages/instructor/views/details/bloc/get_bloc.dart';
import 'package:cadmium_creators/pages/pages.dart';
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
      return _scaffold(context, user, token);
    });
  }

  Widget _scaffold(BuildContext context, User user, String token) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      drawer: NavigationDrawer(user: user),
      body: _instructorBlocProvider(user, token),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CourseCreatePage.routeName);
        },
        child: const Icon(Icons.add),
      ),
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
                  child: _courselistBlocProvider(state.instructor, token)),
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

  Widget _courselistBlocProvider(Instructor instructor, String token) {
    return BlocProvider(
      create: (context) {
        return CourseListBloc(courseRepository: CourseRepository())
          ..add(
              GetCourseListInitial(instructorId: instructor.id, token: token));
      },
      child: BlocBuilder<CourseListBloc, CourseListState>(
        buildWhen: (previous, current) => previous.courses != current.courses,
        builder: (context, state) {
          if (state.status == CourseListGetStatus.success) {
            return SizedBox(
              width: double.infinity,
              child: _CourseListView(
                courses: state.courses,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
        },
      ),
    );
  }
}

class _CourseListView extends StatelessWidget {
  const _CourseListView({Key? key, required this.courses}) : super(key: key);

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    final String token = context.select(
      (AuthenticationBloc bloc) => bloc.state.authKey.key,
    );

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        Course course = courses[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.blue[100],
                child: Text('${course.name[0]}${course.name[1]}'.toUpperCase()),
              ),
              title: Text(course.name),
              // neat trick from stackoverflow
              // https://stackoverflow.com/a/60929451/7450617
              subtitle: Text(course.description.length < 45
                  ? course.description
                  : course.description
                      .replaceRange(45, course.description.length, '...')),
              trailing: IconButton(
                iconSize: 20,
                splashRadius: 20,
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CourseDetailsPage.routeName,
                    arguments: course,
                  ).then((value) {
                    context.read<CourseListBloc>().add(GetCourseListRefresh(
                        instructorId: course.instructorId, token: token));
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
