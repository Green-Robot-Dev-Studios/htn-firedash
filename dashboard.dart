import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final LatLng _center = const LatLng(46.521563, -122.677433);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Marker>> makeMarks() async {
    QuerySnapshot querySnapshot = await firestore.collection("users").get();
    //var list = querySnapshot.documents;
    List<Marker> _markers = <Marker>[];
    querySnapshot.docs.forEach((e) {
      _markers.add(Marker(
          markerId: MarkerId('n/a'),
          position: LatLng(e.data()["lat"], e.data()["lon"]),
          infoWindow: InfoWindow(title: 'n/a')));
    });
    print(_markers);
    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('View active accounts'),
          //backgroundColor: Colors.green[700],
        ),
        body: FutureBuilder<List<Marker>>(
          future: makeMarks(),
          builder: (BuildContext context, AsyncSnapshot<List<Marker>> snap) {
            if (snap.data != null) {
              return GoogleMap(
                markers: Set<Marker>.of(snap.data),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
