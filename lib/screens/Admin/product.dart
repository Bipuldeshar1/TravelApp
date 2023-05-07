import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/navdrawer.dart';

class DashboardProduct extends StatefulWidget {
  DashboardProduct({Key? key}) : super(key: key);

  @override
  State<DashboardProduct> createState() => _DashboardProductState();
}

class _DashboardProductState extends State<DashboardProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('products'),
      ),
    );
  }
}
