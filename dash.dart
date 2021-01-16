import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'map.dart';
import 'dashboard.dart';
import 'install.dart';
import 'info.dart';

class Dash extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: 200,
        child: Scaffold(
          appBar: AppBar(
            title: Text('FireSafe'),
          ),
          body: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('FireSafe'),
                ),
                ListTile(
                  title: Text('Your location'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Map()),
                    );
                  },
                ),
                ListTile(
                  title: Text('See active users'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Photos of your installation'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Install()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Info and checklist'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Info()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Credits'),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(title: Text('Main Dashboard')),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text("Select your location"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Map()),
                );
              },
            ),
            ElevatedButton(
              child: Text("See active users"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Add photos of your installation"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Information and checklist"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
