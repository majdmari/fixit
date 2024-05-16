import 'package:fixit/constants.dart';
import 'package:fixit/screens/admins/admin_home_screen.dart';

import 'package:flutter/material.dart';

class AdminNavigationScreen extends StatefulWidget {
  static String id = 'AdminNavigationScreen';

  @override
  _AdminNavigationScreenState createState() => _AdminNavigationScreenState();
}

class _AdminNavigationScreenState extends State<AdminNavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    AdminHomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: KSurface,
        selectedItemColor: Color(0XffB73B67),
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
