import 'package:cadmium_creators/components/components.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterInstructor extends StatelessWidget {
  const RegisterInstructor({Key? key}) : super(key: key);

  static const routeName = "/registerInstructor";

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
      appBar: AppBar(title: const Text('Register as Instructor')),
      drawer: NavigationDrawer(user: user),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }
}
