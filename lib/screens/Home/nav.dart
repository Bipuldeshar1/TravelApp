import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_3/chat/homePageChat.dart';
import 'package:project_3/model/userModel.dart';
import 'package:project_3/screens/Home/fav.dart';
import 'package:project_3/screens/Home/home.dart';
import 'package:project_3/screens/Home/profile.dart';

class BottomNav extends StatefulWidget {
  UserModel userModel;
  User firebaseUser;

  BottomNav({super.key, 
    required this.firebaseUser,
    required this.userModel,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  late final List<Map<String, dynamic>> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': const HomeScreen()},
      {'page': const FavouriteScreen()},
      {'page': const ProfileScreen()},
      {
        'page': HomePageChat(
          userModel: widget.userModel,
          firebaseUser: widget.firebaseUser,
        )
      },
    ];
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 250, 225, 0),
        onTap: _selectedPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'favourite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: 'profile'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'solo post')
        ],
      ),
    );
  }
}
