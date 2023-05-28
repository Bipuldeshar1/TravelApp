import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/addProducts.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';
import 'package:project_3/screens/Admin/confiremBooking.dart';
import 'package:project_3/screens/Admin/pendingBooking.dart';

import 'package:project_3/screens/Admin/product.dart';
import 'package:project_3/screens/Admin/review.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 45, 20, 50),
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Home(text: 'Home', onClick: () => selectedItem(context, 0)),
              // AddAdmin(
              //     text: 'AddAdmin', onClick: () => selectedItem(context, 1)),
              orders(
                  text: 'Pendeing Bookings',
                  onClick: () => selectedItem(context, 1)),
              AddProducts(
                  text: 'Add Destination',
                  onClick: () => selectedItem(context, 2)),
              product(text: 'Posts', onClick: () => selectedItem(context, 3)),
              Review(text: 'reviews', onClick: () => selectedItem(context, 4)),
              CBooking(
                  text: 'confirmed Bookings',
                  onClick: () => selectedItem(context, 5)),
            ],
          ),
        ),
      ),
    );
  }

//drawer item redirect to corresponding page due to this fxn
  selectedItem(context, int i) {
    switch (i) {
      case 0:
        Navigator.of(context)
            .push((MaterialPageRoute(builder: (context) => AdminHomescreen())));
        break;
      case 1:
        Navigator.of(context)
            .push((MaterialPageRoute(builder: (context) => PendingBooking())));
        break;
      case 2:
        Navigator.of(context).push(
            (MaterialPageRoute(builder: (context) => AddProductScreen())));
        break;
      case 3:
        Navigator.of(context).push(
            (MaterialPageRoute(builder: (context) => DashboardProducts())));
        break;
      case 4:
        Navigator.of(context)
            .push((MaterialPageRoute(builder: (context) => ReviewScreen())));
        break;
      case 5:
        Navigator.of(context)
            .push((MaterialPageRoute(builder: (context) => ConfirmBooking())));
        break;
    }
  }

//function for drawer items
  product({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  AddProducts({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  // AddAdmin({required String text, required Function() onClick}) {
  //   return ListTile(
  //     title: Text(
  //       text,
  //       style: TextStyle(color: Colors.grey),
  //     ),
  //     onTap: onClick,
  //   );
  // }

  orders({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  Home({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  Review({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }

  CBooking({required String text, required Function() onClick}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onClick,
    );
  }
}
