import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_3/screens/Admin/contactpage.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    Future<PermissionStatus> getPermission() async {
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

    void showPermissionDeniedDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permissions error'),
          content: const Text('Please enable access permission in system settings'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Open Settings'),
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
          final PermissionStatus permissionStatus = await getPermission();
          if (permissionStatus == PermissionStatus.granted) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactsPage()));
          } else if (permissionStatus == PermissionStatus.denied) {
            showPermissionDeniedDialog(context);
          }
        },
        child: Container(child: const Text('See')),
      ),
    );
  }
}
