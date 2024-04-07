import 'package:flutter/material.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_card.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Homepage extends StatefulWidget {
  static String id = 'Homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? searchKeyword; // The keyword to search for

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KSurface,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 180, // Adjust the height according to your image
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              cursorColor: Color(0XffB73B67),
              cursorHeight: 20,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
                hintText: 'Search by Name?',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Playfair Display',
                ),
                filled: true,
                fillColor: KSf2,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      searchKeyword = null;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return CustomCard();
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: KSurface,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Container(
            color: KSurface,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GNav(
                backgroundColor: KSurface,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: const Color(0XffB73B67),
                gap: 8,
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    text: 'Favorites',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: 0, // Index of the initially selected tab
                onTabChange: (index) {
                  // Handle tab change
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}