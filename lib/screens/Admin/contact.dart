import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_3/screens/Admin/contactpage.dart';

class Contact extends StatefulWidget {
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    Future<PermissionStatus> _getPermission() async {
      final PermissionStatus permission = await Permission.contacts.status;
      if (permission != PermissionStatus.granted &&
          permission != PermissionStatus.denied) {
        final PermissionStatus requestedPermissionStatus =
            await Permission.contacts.request();
        return requestedPermissionStatus ?? PermissionStatus.denied;
      } else {
        return permission;
      }
    }

    void _showPermissionDeniedDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Permissions error'),
          content: Text('Please enable access permission in system settings'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ElevatedButton(
        onPressed: () async {
          final PermissionStatus permissionStatus = await _getPermission();
          if (permissionStatus == PermissionStatus.granted) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactsPage()));
          } else if (permissionStatus == PermissionStatus.denied) {
            _showPermissionDeniedDialog(context);
          }
        },
        child: Container(child: Text('See')),
      ),
    );
  }
}
