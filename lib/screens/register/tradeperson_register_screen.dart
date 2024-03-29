import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/resources/add_data.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TradepersonRegisterScreen extends StatefulWidget {
  const TradepersonRegisterScreen({super.key});
  static String id = 'TradepersonRegisterScreen';

  @override
  State<TradepersonRegisterScreen> createState() =>
      _TradepersonRegisterScreenState();
}

class _TradepersonRegisterScreenState extends State<TradepersonRegisterScreen> {
  RegisterInfo registerInfo = RegisterInfo();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
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
                    CustomDropdown<String>(
                      items: [
                        'Electrician',
                        'Plumber',
                        'Carpenter',
                        'Painter',
                        'Mason',
                        'Mechanic',
                        'Handyman',
                        'HVAC Technician',
                        'Locksmith',
                        'Roofing Contractor',
                      ],
                      hintText: "Category in menu mode",
                      labelText: "Category",
                      initialValue: null,
                      dropdownMenuBackgroundColor: KSf2,
                      onChanged: (String? value) {
                        setState(() {
                          registerInfo.category = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      onChanged: (value) {
                        registerInfo.desc = value;
                      },
                      hintText: 'Type about you here',
                      label: 'Description',
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
                                // registerViewModel.emailController.text,
                                registerInfo.fullName!,
                                registerInfo.selectedImage!,
                                context);
                          }
                          Map<String, dynamic> additionalData = {
                            'FullName': registerInfo.fullName,
                            'PhoneNumber': registerInfo.phoneNumber,
                            'BirthOfDate': registerInfo.birthOfDate,
                            'City': registerInfo.selectedCity,
                            'Address': registerInfo.address,
                            'Category': registerInfo.category,
                            'Description': registerInfo.desc,
                            'ImageLink': ImageUrl,
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
}
