import 'package:fixit/constants.dart';
import 'package:fixit/screens/admins/admin_home_screen.dart';
import 'package:fixit/screens/profile/admin_profile.dart';
import 'package:fixit/screens/register/user_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNavigationScreen extends StatefulWidget {
  static String id = 'AdminNavigationScreen';

  @override
  _AdminNavigationScreenState createState() => _AdminNavigationScreenState();
}

class _AdminNavigationScreenState extends State<AdminNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);
    final List<Widget> _screens = [
      AdminHomeScreen(),
      AdminProfileScreen(
        adminEmail: registerViewModel.emailController.text,
      )
    ];

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
