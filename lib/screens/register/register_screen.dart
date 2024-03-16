import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/register/tradeperson_register_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/screens/register/user_register_screen.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
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
                CustomTextField(
                  onChanged: (value) {
                    registerInfo.userName = value;
                  },
                  hintText: 'Type your username here',
                  label: 'Username',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: registerViewModel.emailController,
                  onChanged: (value) {
                    registerInfo.email = value;
                  },
                  hintText: 'Type your email here',
                  label: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (value) {
                    registerInfo.password = value;
                  },
                  hintText: 'Type your password here',
                  label: 'Password',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'confirm your password',
                  label: 'Re-Write Password',
                ),
                SizedBox(height: 10),
                CustomDropdown<String>(
                  items: ["Male", 'Female'],
                  hintText: "Gender in menu mode",
                  labelText: "Gender",
                  initialValue: null,
                  dropdownMenuBackgroundColor: KSf2,
                  onChanged: (String? value) {
                    setState(() {
                      registerInfo.selectedGender = value;
                    });
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
                      registerInfo.selectedOption = value;
                    });
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                  text: 'Continue',
                  onTap: () async {
                    CollectionReference collectionReference =
                        FirebaseFirestore.instance.collection('Users');
                    await collectionReference
                        .doc(registerViewModel.emailController.text)
                        .set({
                      'Username': registerInfo.userName,
                      'Email': registerInfo.email,
                      'Password': registerInfo.password,
                      'Gender': registerInfo.selectedGender,
                      'Type': registerInfo.selectedOption,
                    });

                    if (registerInfo.selectedOption == "User") {
                      Navigator.pushNamed(context, UserRegisterScreen.id);
                    } else if (registerInfo.selectedOption == "Tradeperson") {
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
