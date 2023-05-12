import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:project_3/model/packagemodel.dart';
import 'package:project_3/reusableComponent/des.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favourite'),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
