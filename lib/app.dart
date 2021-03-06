import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cadmium_creators/authentication/authentication.dart';
import 'package:cadmium_creators/pages/pages.dart';

import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RegisterInstructor.routeName: (context) => const RegisterInstructor(),
        InstructorDetails.routeName: (context) => const InstructorDetails(),
        UpdateInstructor.routeName: (context) => const UpdateInstructor(),
        CourseListPage.routeName: (context) => const CourseListPage(),
        CourseDetailsPage.routeName: (context) => const CourseDetailsPage(),
        CourseUpdatePage.routeName: (context) => const CourseUpdatePage(),
        CourseCreatePage.routeName: (context) => const CourseCreatePage(),
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
