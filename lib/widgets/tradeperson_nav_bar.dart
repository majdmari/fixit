import 'package:fixit/constants.dart';
import 'package:fixit/screens/favorite_list_screen.dart';
import 'package:fixit/screens/home_page.dart';
import 'package:fixit/screens/profile/tradeperson_profile.dart';
import 'package:fixit/screens/profile/user_profile.dart';
import 'package:flutter/material.dart';

class TradepersonNavigationScreen extends StatefulWidget {
  static String id = 'TradepersonNavigationScreen';

  @override
  _TradepersonNavigationScreenState createState() =>
      _TradepersonNavigationScreenState();
}

class _TradepersonNavigationScreenState
    extends State<TradepersonNavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Homepage(),
    FavoriteListScreen(),
    TradepersonProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
      ),
    );
  }

  // Function to handle back button press
  Future<bool> _onBackPressed() async {
    return false;
  }
}
