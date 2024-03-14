import 'package:fixit/constants.dart';
import 'package:fixit/screens/tradeperson_register_screen.dart';
import 'package:fixit/screens/user_register_screen.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedOption;
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
                CustomTextField(
                  hintText: 'Type your username here',
                  label: 'Username',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Type your email here',
                  label: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Type your password here',
                  label: 'Password',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'confirm your password',
                  label: 'Email',
                ),
                SizedBox(height: 10),
                CustomDropdown<String>(
                  items: ["Male", 'Female'],
                  hintText: "Gender in menu mode",
                  labelText: "Gender",
                  initialValue: null,
                  dropdownMenuBackgroundColor: KSf2,
                  onChanged: (String? value) {
                    print(value);
                  },
                ),
                SizedBox(height: 10),
                CustomDropdown<String>(
                  items: ["User", 'Tradeperson'],
                  hintText: "User Or Tradeperson",
                  labelText: "Who you are ?",
                  initialValue: null,
                  dropdownMenuBackgroundColor: KSf2,
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value;
                    });
                    print(value);
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                  text: 'Continue',
                  onTap: () {
                    if (selectedOption == "User") {
                      Navigator.pushNamed(context, UserRegisterScreen.id);
                    } else if (selectedOption == "Tradeperson") {
                      Navigator.pushNamed(
                          context, TradepersonRegisterScreen.id);
                    } else {
                      // Handle if no option is selected
                      print("Please select an option");
                    }
                    // Navigator.pushNamed(context, TradepersonRegisterScreen.id);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ' Login',
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
