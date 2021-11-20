import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/courses/courses.dart';
import 'package:cadmium_creators/pages/courses/sub_pages/details/bloc/course_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/courseDetails';

  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as Course;

    final courseName = course.name.length < 40
        ? course.name
        : course.name.replaceRange(40, course.name.length, '...');

    final String token = context.select(
      (AuthenticationBloc bloc) => bloc.state.authKey.key,
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          splashRadius: 24,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue[100],
              child: Text('${course.name[0]}${course.name[1]}'.toUpperCase()),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Course',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                Text(
                  courseName,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _scaffoldBody(course, token),
    );
  }

  Widget _scaffoldBody(Course course, token) {
    return BlocProvider(
      create: (context) {
        return CourseDetailBloc(courseRepository: CourseRepository())
          ..add(CourseDetailGetInitial(courseId: course.id, token: token));
      },
      child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        buildWhen: (previous, current) => previous.course != current.course,
        builder: (context, state) {
          if (state.status == CourseDetailGetStatus.success) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: _DetailsWidget(
                    course: state.course,
                  ),
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

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    final String token = context.select(
      (AuthenticationBloc bloc) => bloc.state.authKey.key,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Course ${course.id}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 2,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Text(
                      course.name,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 0.5,
                height: 3,
                color: Colors.black54,
              ),
              const SizedBox(height: 7),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 2,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 5),
                    child: Markdown(
                      data: course.description,
                      shrinkWrap: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              CourseUpdatePage.routeName,
              arguments: course,
            ).then((value) {
              context.read<CourseDetailBloc>().add(
                  CourseDetailGetRefresh(courseId: course.id, token: token));
            });
          },
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
