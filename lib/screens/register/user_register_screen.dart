import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatefulWidget {
  UserRegisterScreen({super.key});
  static String id = 'UserRegisterScreen';

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  RegisterInfo registerInfo = RegisterInfo();
  @override
  Widget build(BuildContext context) {
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                    radius: 68,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onChanged: (value) {
                    registerInfo.fullName = value;
                  },
                  hintText: 'Type your Name here',
                  label: 'Full Name',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (value) {
                    registerInfo.phoneNumber = value;
                  },
                  hintText: '0799999999',
                  label: 'Phone number',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (value) {
                    registerInfo.birthOfDate = value;
                  },
                  hintText: 'DD/MM/YYYY',
                  label: 'Birth of Date',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropdown<String>(
                  items: [
                    'Irbid',
                    'Ajloun',
                    'Jerash',
                    'Mafraq',
                    'Balqa',
                    'Amman',
                    'Zarqa',
                    'Madaba',
                    'Karak',
                    'Tafilah',
                    'Ma\'an',
                    'Aqaba'
                  ],
                  hintText: "City in menu mode",
                  labelText: "City",
                  initialValue: null,
                  dropdownMenuBackgroundColor: KSf2,
                  onChanged: (String? value) {
                    setState(() {
                      registerInfo.selectedCity = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  onChanged: (value) {
                    registerInfo.address = value;
                  },
                  hintText: 'Type your address here',
                  label: 'Address',
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                  text: 'Done',
                  onTap: () async {
                    print('hellosfdsfkisdkjfiosdkgdsgsdgsdgds78gfds8g4dsdgs');
                    Map<String, dynamic> additionalData = {
                      'FullName': registerInfo.fullName,
                      'PhoneNumber': registerInfo.phoneNumber,
                      'BirthOfDate': registerInfo.birthOfDate,
                      'City': registerInfo.selectedCity,
                      'Address': registerInfo.address,
                    };
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(registerViewModel.emailController.text)
                        .update(additionalData);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
