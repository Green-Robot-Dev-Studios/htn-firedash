import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class Map extends StatelessWidget {
  final LatLng _center = const LatLng(46.521563, -122.677433);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
          title: Text('Select your location'),
          //backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        floatingActionButton: Center(
          child: FloatingActionButton(
            child: Icon(Icons.pin_drop),
            onPressed: () async {
              double screenWidth = MediaQuery.of(context).size.width *
                  MediaQuery.of(context).devicePixelRatio;
              double screenHeight = MediaQuery.of(context).size.height *
                  MediaQuery.of(context).devicePixelRatio;

              double middleX = screenWidth / 2;
              double middleY = screenHeight / 2;

              ScreenCoordinate screenCoordinate =
                  ScreenCoordinate(x: middleX.round(), y: middleY.round());
              final GoogleMapController controller = await _controller.future;
              LatLng middlePoint = await controller.getLatLng(screenCoordinate);
              print(middlePoint.latitude.toString() + " Location");
              print(getId());
              CollectionReference users =
                  FirebaseFirestore.instance.collection('users');
              await users.doc(getId()).set(
                  {'lat': middlePoint.latitude, 'lon': middlePoint.longitude});
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
