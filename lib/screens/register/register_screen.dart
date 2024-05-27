import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/helper/show_snack_bar.dart';
import 'package:fixit/screens/register/tradeperson_register_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/screens/register/user_register_screen.dart';
import 'package:fixit/widgets/custom_alert_message.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Register',
              style: TextStyle(color: Colors.white, fontFamily: Kword),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          backgroundColor: KSurface,
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Column(
                    children: [
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
                        onChanged: (value) {
                          registerInfo.confirmPassword = value;
                        },
                        hintText: 'confirm your password',
                        label: 'Re-Write Password',
                      ),
                      SizedBox(height: 10),
                      CustomDropdown<String>(
                        dropdownMenuHeight: 120,
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
                        dropdownMenuHeight: 120,
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
                          if (formKey.currentState!.validate()) {
                            if (registerInfo.password !=
                                registerInfo.confirmPassword) {
                              showCustomDialog(
                                  context, 'Passwords do not match');
                              return;
                            }
                            if (registerInfo.selectedGender == null) {
                              showCustomDialog(
                                  context, "You can't leave gender empty.");
                              return;
                            }
                            if (registerInfo.selectedOption == null) {
                              showCustomDialog(context,
                                  "You can't leave who you are empty.");
                              return;
                            }
                            isLoading = true;
                            setState(() {});
                            try {
                              await registerUser();
                              late CollectionReference
                                  collectionReference; // Declare as late
                              if (registerInfo.selectedOption == "User") {
                                collectionReference = FirebaseFirestore.instance
                                    .collection('users');
                              } else if (registerInfo.selectedOption ==
                                  "Tradeperson") {
                                collectionReference = FirebaseFirestore.instance
                                    .collection('tradepersons');
                              }
                              await collectionReference
                                  .doc(registerViewModel.emailController.text)
                                  .set({
                                'Email': registerInfo.email,
                                'Password': registerInfo.password,
                                'Gender': registerInfo.selectedGender,
                                'Type': registerInfo.selectedOption,
                                'Status': 'Available '
                              });
                              // if (registerInfo.selectedOption == "Tradeperson") {
                              //   await FirebaseFirestore.instance
                              //       .collection('Comment')
                              //       .doc(registerViewModel.emailController.text)
                              //       .collection('comment')
                              //       .doc()
                              //       .set({});
                              // }

                              if (registerInfo.selectedOption == "User") {
                                Navigator.pushNamed(
                                    context, UserRegisterScreen.id);
                              } else if (registerInfo.selectedOption ==
                                  "Tradeperson") {
                                Navigator.pushNamed(
                                    context, TradepersonRegisterScreen.id);
                              }
                            } on FirebaseAuthException catch (ex) {
                              if (ex.code == 'weak-password') {
                                showCustomDialog(context, 'Weak password');
                              } else if (ex.code == 'email-already-in-use') {
                                showCustomDialog(context,
                                    'The account already exists for that email.');
                              }
                            } catch (ex) {
                              showCustomDialog(context, 'There was an error');
                            }
                            isLoading = false;
                            setState(() {});
                          }
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
                                color: Colors.grey, fontFamily: Kword),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              ' Login',
                              style: TextStyle(
                                  color: KSecondary, fontFamily: Kword),
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
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: registerInfo.email!, password: registerInfo.password!);
  }

  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(message: message);
      },
    );
  }

  // Function to handle back button press
  Future<bool> _onBackPressed() async {
    return false;
  }
}
