import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_3/reusableComponent/CustomButton.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';
import 'package:project_3/screens/Admin/product.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Marker? selectedMarker;

  String imageUrl = '';
  String id = const Uuid().v4();

  File? image;
  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      String uniqueid = DateTime.now().microsecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref();
      Reference referenceImage = reference.child('product_Image_post');
      Reference referenceImageToUpload = referenceImage.child(uniqueid);
      try {
        await referenceImageToUpload.putFile(File(image!.path));
        imageUrl = await referenceImageToUpload.getDownloadURL();
      } catch (e) {
        print(e);
      }
      if (image != null) {
        setState(() {
          this.image = File(image.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  final Completer<GoogleMapController> _controller = Completer();
  //GeoPoint userLocation=GeoPoint(latitude, longitude);
  String x = '';
  String y = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.741895, -73.989308),
    zoom: 14.41,
  );
  final List<Marker> _marker = [];
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
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('add Destination'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => pickImage(),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.yellow)),
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.fill,
                          )
                        : const Center(child: Text('click pick an product image')),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  maxLines: null,
                  minLines: 1,
                  maxLength: 200,
                  textInputAction: TextInputAction.newline,
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter des';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  controller: priceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter price';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  controller: numberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter num';
                    } else if (value.length != 10) {
                      return 'number should be equal to 10  char';
                    } else {
                      return null;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('location info:'),
                // Container(
                //   width: double.infinity,
                //   height: 300,
                //   child: SafeArea(
                //     child: GoogleMap(
                //       initialCameraPosition: _kGooglePlex,
                //       onMapCreated: (GoogleMapController controller) {
                //         _controller.complete(controller);
                //       },
                //       mapType: MapType.normal,
                //       myLocationEnabled: true,
                //       compassEnabled: true,
                //       markers: Set<Marker>.of(_marker),
                //       myLocationButtonEnabled: false,
                //       onTap: (argument) async {
                //         setState(() {
                //           getUserCurrentLocation().then((value) async {
                //             print('location current');

                //             print(value.latitude.toString() +
                //                 " " +
                //                 value.longitude.toString());
                //             _marker.add(Marker(
                //               markerId: MarkerId('2'),
                //               position: LatLng(value.latitude, value.longitude),
                //               infoWindow: InfoWindow(title: 'current location'),
                //             ));
                //             CameraPosition cameraPosition = CameraPosition(
                //               target: LatLng(value.latitude, value.longitude),
                //               zoom: 14,
                //             );

                //             final GoogleMapController controller =
                //                 await _controller.future;
                //             controller.animateCamera(
                //                 CameraUpdate.newCameraPosition(cameraPosition));
                //             //lat long for db
                //             x = value.latitude.toString();
                //             y = value.longitude.toString();
                //           });
                //         });
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: SafeArea(
                    child: GoogleMap(
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      markers: Set<Marker>.of(_marker),
                      myLocationButtonEnabled: false,
                      onTap: (LatLng tappedLocation) async {
                        setState(() {
                          getUserCurrentLocation().then((value) async {
                            print('location current');
                            print("${value.latitude} ${value.longitude}");

                            if (selectedMarker != null) {
                              _marker.remove(selectedMarker);
                            }

                            Marker newMarker = Marker(
                              markerId: const MarkerId('2'),
                              position: tappedLocation,
                              infoWindow: const InfoWindow(title: 'current location'),
                            );

                            _marker.add(newMarker);

                            CameraPosition cameraPosition = CameraPosition(
                              target: tappedLocation,
                              zoom: 14,
                            );

                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(cameraPosition));

                            x = tappedLocation.latitude.toString();
                            y = tappedLocation.longitude.toString();

                            selectedMarker = newMarker;
                          });
                        });
                      },
                    ),
                  ),
                ),

                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => NewMap()));
                //     },
                //     child: Text('map')),

                ElevatedButton(
                    onPressed: () {
                      navigateToCurrentLocation();
                    },
                    child: const Icon(Icons.my_location)),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'submit',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addPosts();
                      titleController.clear();
                      descriptionController.clear();
                      numberController.clear();
                      priceController.clear();
                    }
                  },
                  color: Colors.yellow,
                  height: 50,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addPosts() {
    final User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    var date = DateTime.now().toString();
    try {
      FirebaseFirestore.instance
          .collection('Allposts')
          .doc(id) // Use document ID generated by Firestore
          .set({
        'createdOn': date,
        'uId': uid,
        'pId': id,
        'uemail': user.email,
        'title': titleController.text.toString(),
        'description': descriptionController.text.toString(),
        'price': priceController.text.toString(),
        'img': imageUrl,
        'lat': x,
        'lon': y,
        'n': numberController.text.toString(),
        'ratings': 5.toString(),
      }).then((value) {
        FirebaseFirestore.instance.collection('ratings').doc(id).set({
          'ratings': [
            {
              'rid': user.uid,
              'rating': 5.toString(),
              'pid': id,
            }
          ]
        });
      }).then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashboardProducts())));
    } catch (e) {
      print(e);
    }
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error$error');
    });
    return await Geolocator.getCurrentPosition();
  }

  // Function to navigate to the user's current location
  void navigateToCurrentLocation() async {
    final position = await getUserCurrentLocation();
    final cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
}
