import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';

class TradepersonDetailsScreen extends StatefulWidget {
  static String id = 'TradepersonShowToUserScreen';

  final String fullName;
  final String city;
  final String birthDate;
  final String status;
  final String email;
  final String description;
  final String category;

  final String imageUrl; // Add imageUrl to display image

  TradepersonDetailsScreen({
    required this.fullName,
    required this.city,
    required this.birthDate,
    required this.status,
    required this.email,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  @override
  State<TradepersonDetailsScreen> createState() =>
      _TradepersonDetailsScreenState();
}

class _TradepersonDetailsScreenState extends State<TradepersonDetailsScreen> {
  bool isFavorite = false; // Track favorite status

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  void checkFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? "";
      DocumentSnapshot<
          Map<String,
              dynamic>> favoriteSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userEmail)
          .collection('favoriteList')
          .doc(widget
              .email) // Assuming the tradeperson's email is used as the document ID
          .get();
      setState(() {
        isFavorite = favoriteSnapshot.exists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.imageUrl),
                        radius: 68,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.fullName,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                Text(
                  widget.category,
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Email: ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "City : ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      widget.city,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      "BirthDay : ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      widget.birthDate,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    Text(
                      "4.7●",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    GestureDetector(
                      child: Text(
                        "1,399 review",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.description,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      widget.status,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Add favorite button
                IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Function to toggle favorite status
  void toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser; // Get current user
    if (user != null) {
      String userEmail = user.email ?? ""; // Get current user's email

      setState(() {
        isFavorite = !isFavorite;
      });

      if (isFavorite) {
        // Add to favorites in Firebase
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(userEmail)
            .collection('favoriteList')
            .doc(widget
                .email) // Assuming the tradeperson's email is used as the document ID
            .set({
          'FullName': widget.fullName,
          'ImageLink': widget.imageUrl,
          'City': widget.city,
          'Email': widget.email,
          'Desc': widget.description,
          'Category': widget.category,
          'Status': widget.status,
          'BirthOfDate': widget.birthDate,
          // Add other tradeperson details as needed
        });
      } else {
        // Remove from favorites in Firebase
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(userEmail)
            .collection('favoriteList')
            .doc(widget
                .email) // Assuming the tradeperson's email is used as the document ID
            .delete();
      }
    }
  }
}
