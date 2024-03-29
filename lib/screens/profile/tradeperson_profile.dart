import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class TradepersonProfileScreen extends StatefulWidget {
  const TradepersonProfileScreen({super.key});
  static String id = 'TradepersonProfileScreen';

  @override
  State<TradepersonProfileScreen> createState() =>
      _TradepersonProfileScreenState();
}

class _TradepersonProfileScreenState extends State<TradepersonProfileScreen> {
  CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('Users');
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
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://w7.pngwing.com/pngs/205/731/png-transparent-default-avatar-thumbnail.png'),
                    radius: 68,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Majd Mari",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Text(
                  'Electrical',
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
                      "majdmari12@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Phone Number: ",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                    Text(
                      "0799304035",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "City : ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      "Irbid",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "BirthDay : ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Text(
                      "01/10/2002",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )
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
                        "An Electrician is a skilled professional who installs, maintains, and repairs electrical systems in buildings and structures. They execute wiring plans, install fixtures and equipment, and ensure safety compliance. Electricians have expertise in various electrical systems, tools, and safety regulations.",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                CustomButton(text: 'Log out'),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Do You Want To ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Change Password?',
                        style: TextStyle(
                          color: KSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
