// drawer_screen.dart

import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  final Function(String) onDrawerItemPressed;

  const DrawerScreen({Key? key, required this.onDrawerItemPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 84.0, // Adjust the height to match AppBar
            color: Colors.blue, // Optional: Adjust the background color
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              onDrawerItemPressed('Settings');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
