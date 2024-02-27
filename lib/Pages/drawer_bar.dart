// app_drawer.dart

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          Container(
            height: 100.0,
            color: const Color.fromARGB(255, 109, 123, 100),
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(5,10,0,0),
              child: Text(
                'Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            onTap: () {
            },
          ),
          Divider(
            color: Color.fromARGB(100, 255, 255, 255),
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(5,0,0,0),
              child: Text(
                'Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            onTap: () {
            },
          ),
          Divider(
            color: Color.fromARGB(100, 255, 255, 255),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
    );
  }
}
