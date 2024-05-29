import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/helper/show_snack_bar.dart';

import 'package:fixit/screens/register/user_model.dart';

import 'package:fixit/widgets/custom_alert_message.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddAdmin extends StatefulWidget {
  AddAdmin({super.key});
  static String id = 'AddAdmin';

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RegisterInfo registerInfo = RegisterInfo();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Admin',
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
                    // CustomTextField(
                    //   keyboardType: TextInputType.number,
                    //   onChanged: (value) {
                    //     registerInfo.phoneNumber = value;
                    //   },
                    //   hintText: '0799999999',
                    //   label: 'Phone number',
                    // ),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        registerInfo.phoneNumber = value;
                      },
                      hintText: '0799999999',
                      label: 'Phone number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length != 10) {
                          return 'Phone number must be exactly 10 digits';
                        } else if (!value.startsWith('07')) {
                          return 'Phone number must start with 07';
                        }
                        return null;
                      },
                      inputFormatters: [
                        // Add this line
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: _showDatePicker,
                      child: AbsorbPointer(
                        child: CustomTextField(
                          icon: Icons.date_range,
                          controller: TextEditingController(
                              text: _selectedDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate!)
                                  : null),
                          hintText: 'DD/MM/YYYY',
                          label: 'Birth of Date',
                        ),
                      ),
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
                    SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                      text: 'Done',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (registerInfo.password !=
                              registerInfo.confirmPassword) {
                            showCustomDialog(context, 'Passwords do not match');
                            return;
                          }
                          if (registerInfo.selectedGender == null) {
                            showCustomDialog(
                                context, "You can't leave gender empty.");
                            return;
                          }
                          if (registerInfo.selectedCity == null) {
                            showCustomDialog(
                                context, "You can't leave City empty.");
                            return;
                          }
                          isLoading = true;
                          setState(() {});
                          try {
                            await addSubAdmin();

                            await FirebaseFirestore.instance
                                .collection('admins')
                                .doc(registerInfo.email)
                                .set({
                              'Email': registerInfo.email,
                              'Password': registerInfo.password,
                              'FullName': registerInfo.fullName,
                              'Gender': registerInfo.selectedGender,
                              'City': registerInfo.selectedCity,
                              'PhoneNumber': registerInfo.phoneNumber,
                              'Type': 'Admin',
                              'BirthOfDate': _selectedDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate!)
                                  : '',
                            });

                            showSnackBar(context, 'Success');
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addSubAdmin() async {
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
                  Navigator.pop(context); // Close the modal
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: KSecondary, fontFamily: Kword),
                ),
              ),
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
}
