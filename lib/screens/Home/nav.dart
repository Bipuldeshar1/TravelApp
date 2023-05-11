import 'package:flutter/material.dart';
import 'package:project_3/screens/Home/fav.dart';
import 'package:project_3/screens/Home/home.dart';
import 'package:project_3/screens/Home/profile.dart';
import 'package:project_3/screens/Home/soloPost.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': HomeScreen()},
    {'page': FavouriteScreen()},
    {'page': ProfileScreen()},
    {'page': SoloPost()},
  ];
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
        selectedItemColor: Color.fromARGB(255, 250, 225, 0),
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
