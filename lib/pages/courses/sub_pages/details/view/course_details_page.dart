import 'package:cadmium_creators/pages/courses/courses.dart';
import 'package:flutter/material.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/courseDetails';

  // TODO: Fetch data using bloc to allow refreshing after editing
  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as Course;

    final courseName = course.name.length < 40
        ? course.name
        : course.name.replaceRange(40, course.name.length, '...');

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: _DetailsWidget(
                course: course,
              )),
        ),
      ),
    );
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course ${course.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Divider(
          thickness: 0.5,
          height: 3,
          color: Colors.black54,
        ),
        const SizedBox(height: 4),
        const Text(
          'Names',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
