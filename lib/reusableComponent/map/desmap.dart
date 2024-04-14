import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DesMap extends StatefulWidget {
  String a;
  String b;
  DesMap({super.key, 
    required this.a,
    required this.b,
  });

  @override
  State<DesMap> createState() => _DesMapState();
}

class _DesMapState extends State<DesMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _kGooglePlex;
  final List<Marker> _marker = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      double lat = double.parse(widget.a);
      double lan = double.parse(widget.b);
      _kGooglePlex = CameraPosition(
        target: LatLng(
          lat,
          lan,
        ),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414,
      );
      _marker.add(Marker(
          markerId: const MarkerId('1'),
          position: LatLng(lat, lan),
          infoWindow: const InfoWindow(title: 'destination')));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          mapType: MapType.hybrid,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: Set<Marker>.of(_marker),
          myLocationButtonEnabled: true,
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error$error');
    });
    return await Geolocator.getCurrentPosition();
  }
}
