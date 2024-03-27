import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});
  static String id = 'UserProfileScreen';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('Users');
  RegisterInfo? userInfo;

  @override
  void initState() {
    super.initState();
    fetchUserData();
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
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: userInfo != null && userInfo!.selectedImage != null
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(userInfo!.imagePickerFire!),
                          radius: 68,
                        )
                      : CircleAvatar(
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
                      userInfo?.fullName ?? "",
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
                  'User',
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
                      userInfo?.email ?? '',
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
                          "Phone Number:",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                    Text(
                      userInfo?.phoneNumber ?? '',
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
                      userInfo?.selectedCity ?? '',
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
                      userInfo?.birthOfDate ?? '',
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

  Future<void> fetchUserData() async {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    DocumentSnapshot userSnapshot = await usersInfo.doc(userEmail).get();
    setState(() {
      userInfo = RegisterInfo(
        fullName: userSnapshot['FullName'],
        phoneNumber: userSnapshot['PhoneNumber'],
        birthOfDate: userSnapshot['BirthOfDate'],
        selectedCity: userSnapshot['City'],
        address: userSnapshot['Address'],
        email: userSnapshot['Email'],
        imagePickerFire: userSnapshot['ImageLink'],
        selectedImage: userSnapshot['ImageLink'],

        // Add other fields as needed
      );
      print(userInfo!.imagePickerFire);
    });
  }
}
