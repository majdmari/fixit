import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';

class TradepersonDetailsScreen extends StatelessWidget {
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
                        backgroundImage: NetworkImage(imageUrl),
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
                      fullName,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                Text(
                  category,
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
                      email,
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
                      city,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      "BirthDay : ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      birthDate,
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
                        description,
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
                      status,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
