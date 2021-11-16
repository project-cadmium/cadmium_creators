import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:cadmium_creators/pages/pages.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.white,
                  child: Text('${user.firstName[0]}${user.lastName[0]}'),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    // fontSize: 20.0,
                    // fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Register Instructor'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RegisterInstructor.routeName);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
