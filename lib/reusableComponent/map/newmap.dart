import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_3/reusableComponent/map/locationService.dart';

class NewMap extends StatefulWidget {
  const NewMap({super.key});

  @override
  State<NewMap> createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  final _searchController = TextEditingController();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.712021, 85.312950),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _kLakeMarker = Marker(
    markerId: MarkerId('1'),
    infoWindow: InfoWindow(title: 'lake'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(27.687967, 85.320479),
  );
  static final Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('2'),
    infoWindow: InfoWindow(title: 'google'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(27.712021, 85.312950),
  );

  static final Polyline _kPolyLine =
      Polyline(polylineId: PolylineId('_polyline'), points: [
    LatLng(27.687967, 85.320479),
    LatLng(27.712021, 85.312950),
  ]);
  static final Polygon _kpolygon = Polygon(
    polygonId: PolygonId('_kpolygon'),
    points: [
      LatLng(27.687967, 85.320479),
      LatLng(27.68796712, 85.320479),
      LatLng(27.712021, 85.312950),
      LatLng(27.71202112, 85.312950),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'google map',
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(hintText: 'search by city'),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
                  var place =
                      await LocationService().getPlace(_searchController.text);
                  _goToplace(place);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.75,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {_kLakeMarker, _kGooglePlexMarker},
              // polylines: {_kPolyLine},
              // polygons: {_kpolygon},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goToplace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 14,
    )));
  }
}
