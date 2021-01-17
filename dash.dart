import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'map.dart';
import 'dashboard.dart';
import 'install.dart';
import 'info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Dash extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void token() async {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    print(await fbm.getToken());
  }

  @override
  Widget build(BuildContext context) {
    token();
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
                // DrawerHeader(
                //   child: Text('FireSafe'),
                // ),
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
                  title: Text('See active users (Admin)'),
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
        child: ListView(
          children: <Widget>[
            Expanded(
              child: Container(
                width: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueAccent,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.pin_drop, size: 70),
                        title: Text('Select your location',
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text('You only need to do this once',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Ok',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Map()),
                                );
                              },
                            ),
                            FlatButton(
                              child: const Text('Ignore',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueAccent,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.map, size: 70),
                        title: Text('See active users',
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text('Admin only',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Ok',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              },
                            ),
                            FlatButton(
                              child: const Text('Ignore',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueAccent,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.upload_file, size: 70),
                        title: Text('Upload pictures of your installation',
                            style: TextStyle(color: Colors.white)),
                        subtitle:
                            Text('', style: TextStyle(color: Colors.white)),
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Ok',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Install()),
                                );
                              },
                            ),
                            FlatButton(
                              child: const Text('Ignore',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueAccent,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album, size: 70),
                        title: Text('Info page',
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text('Read through this at least once',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Ok',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Info()),
                                );
                              },
                            ),
                            FlatButton(
                              child: const Text('Ignore',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ElevatedButton(
            //   child: Text("Select your location"),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Map()),
            //     );
            //   },
            // ),
            // ElevatedButton(
            //   child: Text("See active users"),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Dashboard()),
            //     );
            //   },
            // ),
            // ElevatedButton(
            //   child: Text("Add photos of your installation"),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Dashboard()),
            //     );
            //   },
            // ),
            // ElevatedButton(
            //   child: Text("Information and checklist"),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Dashboard()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
