import 'package:fixit/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Register',
          style: TextStyle(color: Colors.black),
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
                  initialValue: "Male",
                  dropdownMenuBackgroundColor: KSf2,
                  onChanged: (String? value) {
                    print(value);
                  },
                ),
                SizedBox(height: 200),
                CustomTextField(
                  hintText: 'User or Tradeperson',
                  label: 'Who you are ?',
                  icon: Icons.arrow_drop_down,
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(text: 'Login'),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        'already have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
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
