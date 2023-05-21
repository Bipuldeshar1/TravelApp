import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
 
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  //GeoPoint userLocation=GeoPoint(latitude, longitude);
  String x = '';
  String y = '';

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.741895, -73.989308),
    zoom: 14.41,
  );
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(40.741895, -73.989308),
      infoWindow: InfoWindow(
        title: 'my position',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: Set<Marker>.of(_marker),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            getUserCurrentLocation().then((value) async {
              print('location current');

              print(
                  value.latitude.toString() + " " + value.longitude.toString());
              _marker.add(Marker(
                markerId: MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(title: 'current location'),
              ));
              CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 14,
              );

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              //lat long for db
              x = value.latitude.toString();
              y = value.longitude.toString();

              // FirebaseFirestore.instance.collection('map_Coord').doc().set({
              //   'lat': x,
              //   'lon': y,
              //   'sid': FirebaseAuth.instance.currentUser!.uid,
              // });
            });
          });
        },
        child: Icon(
          Icons.location_city,
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error' + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}
