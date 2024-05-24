import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/pop_up_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfileScreen extends StatefulWidget {
  AdminProfileScreen({super.key, this.adminEmail});
  static String id = 'AdminProfileScreen';
  String? adminEmail;

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('admins');
  RegisterInfo? userInfo;
  bool isLoading = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontFamily: Kword),
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
                        backgroundImage:
                            AssetImage('assets/images/adminProfile.png'),
                        radius: 68,
                      )),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userInfo?.fullName ?? "",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomPopUpDialog(
                                    message: 'The FullName cannot be empty.',
                                    text: "Edit Name",
                                    label: 'Full name',
                                    hintText: 'Enter your Full name here',
                                    onSave: updateFullName);
                              });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: Kword),
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
                            "Phone Number: ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: Kword),
                          ),
                        ],
                      ),
                      Text(
                        userInfo?.phoneNumber ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomPopUpDialog(
                                  message: 'The phone number cannot be empty.',
                                  text: "Edit Phone",
                                  label: 'Phone Number',
                                  hintText: 'Enter your Phone Number here',
                                  keyboardType: TextInputType.number,
                                  onSave: updatePhoneNumber,
                                );
                              });
                        },
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: Kword),
                      ),
                      Text(
                        userInfo?.selectedCity ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDropdownPopup(
                                title: 'select city',
                                items: ['irbid', 'amman'],
                                hintText: 'choose city',
                                labelText: 'City',
                                message: "Please select a city",
                                onSave: (selectedCity) {
                                  // Save the selected city to Firestore
                                  updateCity(selectedCity);
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "BirthDay : ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: Kword),
                        ),
                        Text(
                          userInfo?.birthOfDate ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        IconButton(
                          onPressed: () {
                            _showDatePicker();
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      ]),
                  SizedBox(height: 10),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Log out',
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', false);
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                      registerViewModel.emailController.text = '';
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Do You Want To ',
                        style: TextStyle(color: Colors.grey, fontFamily: Kword),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ChangePasswordDialog(
                                onChangePassword: (String newPassword) {
                                  changePassword(newPassword);
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          'Change Password?',
                          style:
                              TextStyle(color: KSecondary, fontFamily: Kword),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });
    DocumentSnapshot userSnapshot =
        await usersInfo.doc(widget.adminEmail).get();
    setState(() {
      userInfo = RegisterInfo(
        fullName: userSnapshot['FullName'],
        phoneNumber: userSnapshot['PhoneNumber'],
        birthOfDate: userSnapshot['BirthOfDate'],
        selectedCity: userSnapshot['City'],
        email: userSnapshot['Email'],

        // Add other fields as needed
      );
      isLoading = false;
    });
  }

  Future<void> updateFullName(String newName) async {
    await usersInfo.doc(widget.adminEmail).update({'FullName': newName});
    // Update local state after updating in Firestore
    setState(() {
      userInfo?.fullName = newName;
    });
  }

  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    await usersInfo
        .doc(widget.adminEmail)
        .update({'PhoneNumber': newPhoneNumber});
    // Update local state after updating in Firestore
    setState(() {
      userInfo?.phoneNumber = newPhoneNumber;
    });
  }

  Future<void> changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.updatePassword(newPassword);

      await usersInfo.doc(widget.adminEmail).update({'Password': newPassword});
      // Show success message or navigate to another screen
      // You can also update the UI as needed
    } catch (e) {
      // Handle password change failure (e.g., show error message)
      print("Failed to update password: $e");
    }
  }

  // Function to update the selected city in Firestore
  Future<void> updateCity(String newCity) async {
    try {
      await usersInfo.doc(widget.adminEmail).update({'City': newCity});

      // Update local state after updating in Firestore
      setState(() {
        userInfo?.selectedCity = newCity;
      });
    } catch (e) {
      // Handle errors
      print('Failed to update city: $e');
    }
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    if (_selectedDate != null) {
                      _updateBirthDate(_selectedDate!);
                      Navigator.pop(context); // Close the modal
                    }
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(color: KSecondary, fontFamily: Kword),
                  )),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime(1990),
                  maximumDate: DateTime.now().add(Duration(days: 1)),
                  initialDateTime: _selectedDate ?? DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      _selectedDate = newDateTime;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateBirthDate(DateTime newDate) async {
    String formattedDate = DateFormat('dd/MM/yyyy').format(newDate);
    await usersInfo
        .doc(widget.adminEmail)
        .update({'BirthOfDate': formattedDate});
    setState(() {
      userInfo?.birthOfDate = formattedDate;
    });
  }
}
