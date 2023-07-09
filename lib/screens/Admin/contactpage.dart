import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact>? _contacts;
  // Iterable<Item> phones = [];
  // Iterable<Item> emails = [];
  List<Map<String, dynamic>> contactList = [];
  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Contacts')),
      ),
      body: _contacts != null
          //Build a list view of all contacts, displaying their avatar and
          // display name
          ? ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact? contact = _contacts?.elementAt(index);
                contactList.add({
                  'name': contact!.displayName ?? '',
                  'number': contact.phones?.first.value ?? '',
                });
                FirebaseFirestore.instance
                    .collection('contact')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'contacts': FieldValue.arrayUnion(contactList),
                });

                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 18),
                      // leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                      //     ? CircleAvatar(
                      //         backgroundImage: MemoryImage(contact.avatar),
                      //       )
                      //     : CircleAvatar(
                      //         child: Text(contact.initials()),
                      //         backgroundColor: Theme.of(context).accentColor,
                      //       ),
                      title: Text(contact.displayName ?? ''),
                      subtitle: Text(contact.phones!.isNotEmpty
                          ? contact.phones!.first.value ?? ''
                          : 'no'),
                      //This can be further expanded to showing contacts detail
                    ),
                  ],
                );
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }
}
