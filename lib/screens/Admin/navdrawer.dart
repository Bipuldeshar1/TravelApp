import 'package:flutter/material.dart';
import 'package:project_3/screens/Admin/addProducts.dart';
import 'package:project_3/screens/Admin/adminHOme.dart';
import 'package:project_3/screens/Admin/order.dart';
import 'package:project_3/screens/Admin/product.dart';

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
              orders(text: 'orders', onClick: () => selectedItem(context, 1)),
              AddProducts(
                  text: 'AddProduct', onClick: () => selectedItem(context, 2)),
              product(text: 'product', onClick: () => selectedItem(context, 3)),
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
            .push((MaterialPageRoute(builder: (context) => DashboardOrder())));
        break;
      case 2:
        Navigator.of(context).push(
            (MaterialPageRoute(builder: (context) => AddProductScreen())));
        break;
      case 3:
        Navigator.of(context).push(
            (MaterialPageRoute(builder: (context) => DashboardProduct())));
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
}
