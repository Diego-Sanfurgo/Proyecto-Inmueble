import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String name;
  final IconData icon;

  CustomTile({@required this.name, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              name,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            tileColor: Colors.deepPurpleAccent[400],
          ),
          Divider(
            height: 18,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
