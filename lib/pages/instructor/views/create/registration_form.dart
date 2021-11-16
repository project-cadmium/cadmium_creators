import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your biography to register',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          const TextField(
            minLines: 4,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Biography',
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                double.minPositive,
                40,
              ), // double.infinity is the width and 30 is the height
            ),
            onPressed: () {},
            child: const Text('Register'),
          )
        ],
      ),
    );
  }
}
