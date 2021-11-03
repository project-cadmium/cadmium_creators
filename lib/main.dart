import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadmium Creators',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 0.0),
                        child: Text(
                          'Cadmium Creators',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Sign in to your account to continue',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            // color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email Address'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                          obscureText: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (bool? value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 0.0),
                              child: Text('Remember me'),
                            ),
                            Expanded(child: Container()),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              40,
                            ), // double.infinity is the width and 30 is the height
                          ),
                          onPressed: () {},
                          child: const Text('Sign In'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 0.0),
                              child: Text('Don\'t have an account?'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Get started'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
