import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Settings"),
      ),
      body: _AdminView(),
    );
  }
}

class _AdminView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Reset System"),
          subtitle: Text("Wipe all data"),
          trailing: FlatButton(
            onPressed: () {},
            color: Colors.red,
            child: Text(
              "Reset",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text("Version of API"),
          subtitle: Text("Wipe all data"),
          trailing: FlatButton(
            onPressed: () {},
            color: Colors.red,
            child: Text(
              "Reset",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
