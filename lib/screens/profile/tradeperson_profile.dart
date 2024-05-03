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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradepersonProfileScreen extends StatefulWidget {
  const TradepersonProfileScreen({super.key});
  static String id = 'TradepersonProfileScreen';

  @override
  State<TradepersonProfileScreen> createState() =>
      _TradepersonProfileScreenState();
}

class _TradepersonProfileScreenState extends State<TradepersonProfileScreen> {
  CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('tradepersons');
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
                        child: userInfo != null &&
                                userInfo!.imagePickerFire != null
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
                      Positioned(
                        left: 105,
                        top: 105,
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
                    userInfo?.category ?? '',
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
                            "Phone Number: ",
                            style: TextStyle(color: Colors.white, fontSize: 17),
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
                        style: TextStyle(color: Colors.white, fontSize: 17),
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
                          "Adress : ",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Text(
                          userInfo?.address ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomPopUpDialog(
                                    message: 'The Adress cannot be empty.',
                                    text: "Edit Adress",
                                    label: 'Adress',
                                    hintText: 'Enter your Adress here',
                                    onSave: updateAddress,
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      ]),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "BirthDay : ",
                          style: TextStyle(color: Colors.white, fontSize: 17),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        userInfo?.selectedStatus ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDropdownPopup(
                                title: 'Select Status',
                                items: ['Active', 'Inactive', 'Busy', 'Away'],
                                hintText: 'Choose status',
                                labelText: 'Status',
                                message:
                                    'Please select a status', // Error message if no status is selected
                                onSave: (selectedStatus) {
                                  updateStatus(selectedStatus);
                                },
                              );
                            },
                          );
                        },
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
                          userInfo?.desc ?? '',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomPopUpDialog(
                                    message: 'The Description cannot be empty.',
                                    text: "Edit Description",
                                    label: 'Description',
                                    hintText: 'Enter your Description here',
                                    onSave: updateDesc);
                              });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Log out',
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', false);
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                    },
                  ),
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
      ),
    );
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });
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
        desc: userSnapshot['Description'],
        category: userSnapshot['Category'],
        selectedStatus: userSnapshot['Status'],

        // Add other fields as needed
      );
      isLoading = false;
    });
  }

  Future<void> updateFullName(String newName) async {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    await usersInfo.doc(userEmail).update({'FullName': newName});
    // Update local state after updating in Firestore
    setState(() {
      userInfo?.fullName = newName;
    });
  }

  Future<void> updateDesc(String newDesc) async {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    await usersInfo.doc(userEmail).update({'Description': newDesc});
    // Update local state after updating in Firestore
    setState(() {
      userInfo?.desc = newDesc;
    });
  }

  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    await usersInfo.doc(userEmail).update({'PhoneNumber': newPhoneNumber});
    // Update local state after updating in Firestore
    setState(() {
      userInfo?.phoneNumber = newPhoneNumber;
    });
  }

  Future<void> changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.updatePassword(newPassword);

      String userEmail = user.email!;
      await usersInfo.doc(userEmail).update({'Password': newPassword});
      // Show success message or navigate to another screen
      // You can also update the UI as needed
    } catch (e) {
      // Handle password change failure (e.g., show error message)
      print("Failed to update password: $e");
    }
  }

  Future<void> _pickImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List bytes = await pickedFile.readAsBytes();
      String userEmail = FirebaseAuth.instance.currentUser!.email!;
      String imagePath = 'images/$userEmail/${DateTime.now()}';
      Reference ref = FirebaseStorage.instance.ref().child(imagePath);
      UploadTask uploadTask = ref.putData(bytes);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await usersInfo.doc(userEmail).update({'ImageLink': downloadUrl});
      setState(() {
        userInfo?.imagePickerFire = downloadUrl;
      });
    }
  }

  // Function to update the selected city in Firestore
  Future<void> updateCity(String newCity) async {
    try {
      String userEmail = FirebaseAuth.instance.currentUser!.email!;
      await usersInfo.doc(userEmail).update({'City': newCity});

      // Update local state after updating in Firestore
      setState(() {
        userInfo?.selectedCity = newCity;
      });
    } catch (e) {
      // Handle errors
      print('Failed to update city: $e');
    }
  }

  Future<void> updateStatus(String newStatus) async {
    try {
      String userEmail = FirebaseAuth.instance.currentUser!.email!;
      await usersInfo.doc(userEmail).update({'Status': newStatus});

      // Update local state after updating in Firestore
      setState(() {
        userInfo?.selectedStatus = newStatus;
      });
    } catch (e) {
      // Handle errors
      print('Failed to update status: $e');
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
                    style: TextStyle(color: KSecondary),
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
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    String formattedDate = DateFormat('dd/MM/yyyy').format(newDate);
    await usersInfo.doc(userEmail).update({'BirthOfDate': formattedDate});
    setState(() {
      userInfo?.birthOfDate = formattedDate;
    });
  }

  Future<void> updateAddress(String newAdress) async {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    await usersInfo.doc(userEmail).update({
      'Address': newAdress
    }); // Update local state after updating in Firestore
    setState(() {
      userInfo?.address = newAdress;
    });
  }
}
