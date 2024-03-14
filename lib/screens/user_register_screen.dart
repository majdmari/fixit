import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});
  static String id = 'UserRegisterScreen';

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  @override
  Widget build(BuildContext context) {
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
                  hintText: 'Type your Name here',
                  label: 'Full Name',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: '0799999999',
                  label: 'Phone number',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
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
                    print(value);
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Type your address here',
                  label: 'Address',
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                  text: 'Done',
                  onTap: () {},
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
