import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';

import '../../model/packagemodel.dart';

class DashboardOrder extends StatefulWidget {
  DashboardOrder({Key? key}) : super(key: key);

  @override
  State<DashboardOrder> createState() => _DashboardOrderState();
}

class _DashboardOrderState extends State<DashboardOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('orders'),
      ),
    );
  }
}
