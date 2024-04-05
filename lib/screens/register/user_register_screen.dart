import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/resources/add_data.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatefulWidget {
  UserRegisterScreen({super.key});
  static String id = 'UserRegisterScreen';

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  RegisterInfo registerInfo = RegisterInfo();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  DateTime? _selectedDate;

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
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: registerInfo.selectedImage != null
                            ? CircleAvatar(
                                backgroundImage:
                                    MemoryImage(registerInfo.selectedImage!),
                                radius: 68,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://w7.pngwing.com/pngs/205/731/png-transparent-default-avatar-thumbnail.png'),
                                radius: 68,
                              ),
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        registerInfo.phoneNumber = value;
                      },
                      hintText: '0799999999',
                      label: 'Phone number',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // CustomTextField(
                    //   onChanged: (value) {
                    //     registerInfo.birthOfDate = value;
                    //   },
                    //   hintText: 'DD/MM/YYYY',
                    //   label: 'Birth of Date',
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: _showDatePicker,
                      child: AbsorbPointer(
                        child: CustomTextField(
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
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          String ImageUrl = '';
                          if (registerInfo.selectedImage != null) {
                            ImageUrl = await StoreDate().uploadImageToStorage(
                                registerInfo.selectedImage!, context);
                          }
                          Map<String, dynamic> additionalData = {
                            'FullName': registerInfo.fullName,
                            'PhoneNumber': registerInfo.phoneNumber,
                            // 'BirthOfDate': registerInfo.birthOfDate,
                            'BirthOfDate': _selectedDate != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate!)
                                : '',
                            'City': registerInfo.selectedCity,
                            'Address': registerInfo.address,
                            'ImageLink': ImageUrl
                          };
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(registerViewModel.emailController.text)
                              .update(additionalData);
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

  Future<void> _pickImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        registerInfo.selectedImage = File(pickedFile.path).readAsBytesSync();
      });
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
                  Navigator.pop(context); // Close the modal
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: KSecondary),
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
