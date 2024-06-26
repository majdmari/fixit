// import 'dart:io';
// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/constants.dart';
// import 'package:fixit/resources/add_data.dart';
// import 'package:fixit/screens/login_screen.dart';
// import 'package:fixit/screens/register/user_model.dart';
// import 'package:fixit/screens/subscription_reg_screen.dart';
// import 'package:fixit/widgets/custom_alert_message.dart';
// import 'package:fixit/widgets/custom_button.dart';
// import 'package:fixit/widgets/custom_drop_down.dart';
// import 'package:fixit/widgets/custom_text_field.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:provider/provider.dart';

// class TradepersonRegisterScreen extends StatefulWidget {
//   const TradepersonRegisterScreen({super.key});
//   static String id = 'TradepersonRegisterScreen';

//   @override
//   State<TradepersonRegisterScreen> createState() =>
//       _TradepersonRegisterScreenState();
// }

// class _TradepersonRegisterScreenState extends State<TradepersonRegisterScreen> {
//   RegisterInfo registerInfo = RegisterInfo();
//   GlobalKey<FormState> formKey = GlobalKey();
//   bool isLoading = false;
//   DateTime? _selectedDate;

//   @override
//   Widget build(BuildContext context) {
//     final RegisterViewModel registerViewModel =
//         Provider.of<RegisterViewModel>(context);
//     return ModalProgressHUD(
//       inAsyncCall: isLoading,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text(
//             'Register',
//             style: TextStyle(color: Colors.white, fontFamily: Kword),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//         ),
//         backgroundColor: KSurface,
//         body: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Form(
//             key: formKey,
//             child: ListView(
//               children: [
//                 Column(
//                   children: [
//                     GestureDetector(
//                       onTap: _pickImage,
//                       child: CircleAvatar(
//                         radius: 70,
//                         backgroundColor: Colors.white,
//                         child: registerInfo.selectedImage != null
//                             ? CircleAvatar(
//                                 backgroundImage:
//                                     MemoryImage(registerInfo.selectedImage!),
//                                 radius: 68,
//                               )
//                             : CircleAvatar(
//                                 backgroundImage: NetworkImage(
//                                     'https://w7.pngwing.com/pngs/205/731/png-transparent-default-avatar-thumbnail.png'),
//                                 radius: 68,
//                               ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomTextField(
//                       onChanged: (value) {
//                         registerInfo.fullName = value;
//                       },
//                       hintText: 'Type your Name here',
//                       label: 'Full Name',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     CustomTextField(
//                       onChanged: (value) {
//                         registerInfo.phoneNumber = value;
//                       },
//                       hintText: '0799999999',
//                       keyboardType: TextInputType.number,
//                       label: 'Phone number',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     GestureDetector(
//                       onTap: _showDatePicker,
//                       child: AbsorbPointer(
//                         child: CustomTextField(
//                           icon: Icons.date_range,
//                           controller: TextEditingController(
//                               text: _selectedDate != null
//                                   ? DateFormat('dd/MM/yyyy')
//                                       .format(_selectedDate!)
//                                   : null),
//                           hintText: 'DD/MM/YYYY',
//                           label: 'Birth of Date',
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     CustomDropdown<String>(
//                       items: [
//                         'Irbid',
//                         'Ajloun',
//                         'Jerash',
//                         'Mafraq',
//                         'Balqa',
//                         'Amman',
//                         'Zarqa',
//                         'Madaba',
//                         'Karak',
//                         'Tafilah',
//                         'Ma\'an',
//                         'Aqaba'
//                       ],
//                       hintText: "City in menu mode",
//                       labelText: "City",
//                       initialValue: null,
//                       dropdownMenuBackgroundColor: KSf2,
//                       onChanged: (String? value) {
//                         setState(() {
//                           registerInfo.selectedCity = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     CustomTextField(
//                       onChanged: (value) {
//                         registerInfo.address = value;
//                       },
//                       hintText: 'Type your address here',
//                       label: 'Address',
//                     ),
//                     SizedBox(height: 10),
//                     CustomDropdown<String>(
//                       items: [
//                         'Electrician',
//                         'Plumber',
//                         'Carpenter',
//                         'Painter',
//                         'Mason',
//                         'Mechanic',
//                         'Handyman',
//                         'HVAC Technician',
//                         'Locksmith',
//                         'Roofing Contractor',
//                       ],
//                       hintText: "Category in menu mode",
//                       labelText: "Category",
//                       initialValue: null,
//                       dropdownMenuBackgroundColor: KSf2,
//                       onChanged: (String? value) {
//                         setState(() {
//                           registerInfo.category = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     CustomTextField(
//                       onChanged: (value) {
//                         registerInfo.desc = value;
//                       },
//                       hintText: 'Type about you here',
//                       label: 'Description',
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     CustomButton(
//                       text: 'Done',
//                       onTap: () async {
//                         if (formKey.currentState!.validate()) {
//                           if (registerInfo.selectedCity == null) {
//                             showCustomDialog(
//                                 context, "You can't leave City empty.");
//                             return;
//                           }
//                           if (registerInfo.category == null) {
//                             showCustomDialog(
//                                 context, "You can't leave Category empty.");
//                             return;
//                           }
//                           isLoading = true;
//                           setState(() {});
//                           String ImageUrl = '';
//                           if (registerInfo.selectedImage != null) {
//                             ImageUrl = await StoreDate().uploadImageToStorage(
//                                 // registerViewModel.emailController.text,

//                                 registerInfo.selectedImage!,
//                                 context);
//                           } else {
//                             DocumentSnapshot userSnapshot =
//                                 await FirebaseFirestore.instance
//                                     .collection('tradepersons')
//                                     .doc(registerViewModel.emailController.text)
//                                     .get();
//                             String gender = userSnapshot.get('Gender');
//                             // Upload default image based on gender
//                             if (gender == 'Male') {
//                               ImageUrl = await _uploadDefaultImage(
//                                   'assets/images/male.png', context);
//                             } else if (gender == 'Female') {
//                               ImageUrl = await _uploadDefaultImage(
//                                   'assets/images/female.png', context);
//                             }
//                           }
//                           Map<String, dynamic> additionalData = {
//                             'FullName': registerInfo.fullName,
//                             'PhoneNumber': registerInfo.phoneNumber,
//                             'BirthOfDate': _selectedDate != null
//                                 ? DateFormat('dd/MM/yyyy')
//                                     .format(_selectedDate!)
//                                 : '',
//                             'City': registerInfo.selectedCity,
//                             'Address': registerInfo.address,
//                             'Category': registerInfo.category,
//                             'Description': registerInfo.desc,
//                             'ImageLink': ImageUrl,
//                             'TotalRating': 0,
//                             'ReviewsNumber': 0,
//                             'AverageRating': 0
//                           };
//                           await FirebaseFirestore.instance
//                               .collection('tradepersons')
//                               .doc(registerViewModel.emailController.text)
//                               .update(additionalData);
//                           isLoading = false;
//                           setState(() {});

//                           await showCustomDialogg(
//                               context,
//                               'your account created successfully',
//                               'Create account');
//                           Navigator.pushNamed(
//                               context, SubscriptionRegScreen.id);
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     XFile? pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         registerInfo.selectedImage = File(pickedFile.path).readAsBytesSync();
//       });
//     }
//   }

//   void _showDatePicker() {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.4,
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the modal
//                 },
//                 child: Text(
//                   'Done',
//                   style: TextStyle(color: KSecondary, fontFamily: Kword),
//                 ),
//               ),
//               Expanded(
//                 child: CupertinoDatePicker(
//                   mode: CupertinoDatePickerMode.date,
//                   minimumDate: DateTime(1900),
//                   maximumDate: DateTime.now().add(Duration(days: 1)),
//                   initialDateTime: _selectedDate ?? DateTime.now(),
//                   onDateTimeChanged: (DateTime newDateTime) {
//                     setState(() {
//                       _selectedDate = newDateTime;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> showCustomDialogg(
//       BuildContext context, String message, String? title) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomAlertDialog(
//           message: message,
//           title: title,
//         );
//       },
//     );
//   }

//   void showCustomDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomAlertDialog(message: message);
//       },
//     );
//   }

//   Future<String> _uploadDefaultImage(
//       String defaultImagePath, BuildContext context) async {
//     ByteData byteData = await rootBundle.load(defaultImagePath);
//     Uint8List defaultImageBytes = byteData.buffer.asUint8List();
//     return await StoreDate().uploadImageToStorage(defaultImageBytes, context);
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/resources/add_data.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/screens/subscription_reg_screen.dart';
import 'package:fixit/widgets/custom_alert_message.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TradepersonRegisterScreen extends StatefulWidget {
  const TradepersonRegisterScreen({Key? key}) : super(key: key);
  static String id = 'TradepersonRegisterScreen';

  @override
  State<TradepersonRegisterScreen> createState() =>
      _TradepersonRegisterScreenState();
}

class _TradepersonRegisterScreenState extends State<TradepersonRegisterScreen> {
  RegisterInfo registerInfo = RegisterInfo();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  DateTime? _selectedDate;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Categorys').get();
    setState(() {
      categories =
          querySnapshot.docs.map((doc) => doc['Category'] as String).toList();
    });
  }

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
                      // CustomTextField(
                      //   onChanged: (value) {
                      //     registerInfo.phoneNumber = value;
                      //   },
                      //   hintText: '0799999999',
                      //   keyboardType: TextInputType.number,
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
                        items: categories,
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
                            if (registerInfo.category == null) {
                              showCustomDialog(
                                  context, "You can't leave Category empty.");
                              return;
                            }
                            isLoading = true;
                            setState(() {});
                            String ImageUrl = '';
                            if (registerInfo.selectedImage != null) {
                              ImageUrl = await StoreDate().uploadImageToStorage(
                                  // registerViewModel.emailController.text,

                                  registerInfo.selectedImage!,
                                  context);
                            } else {
                              DocumentSnapshot userSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('tradepersons')
                                      .doc(registerViewModel
                                          .emailController.text)
                                      .get();
                              String gender = userSnapshot.get('Gender');
                              // Upload default image based on gender
                              if (gender == 'Male') {
                                ImageUrl = await _uploadDefaultImage(
                                    'assets/images/male.png', context);
                              } else if (gender == 'Female') {
                                ImageUrl = await _uploadDefaultImage(
                                    'assets/images/female.png', context);
                              }
                            }
                            Map<String, dynamic> additionalData = {
                              'FullName': registerInfo.fullName,
                              'PhoneNumber': registerInfo.phoneNumber,
                              'BirthOfDate': _selectedDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate!)
                                  : '',
                              'City': registerInfo.selectedCity,
                              'Address': registerInfo.address,
                              'Category': registerInfo.category,
                              'Description': registerInfo.desc,
                              'ImageLink': ImageUrl,
                              'TotalRating': 0,
                              'ReviewsNumber': 0,
                              'AverageRating': 0
                            };
                            await FirebaseFirestore.instance
                                .collection('tradepersons')
                                .doc(registerViewModel.emailController.text)
                                .update(additionalData);
                            isLoading = false;
                            setState(() {});

                            await showCustomDialogg(
                                context,
                                'your account created successfully',
                                'Create account');
                            Navigator.pushNamed(
                                context, SubscriptionRegScreen.id);
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
                  style: TextStyle(color: KSecondary, fontFamily: Kword),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime(1900),
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

  Future<void> showCustomDialogg(
      BuildContext context, String message, String? title) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          message: message,
          title: title,
        );
      },
    );
  }

  // Function to handle back button press
  Future<bool> _onBackPressed() async {
    return false;
  }

  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(message: message);
      },
    );
  }

  Future<String> _uploadDefaultImage(
      String defaultImagePath, BuildContext context) async {
    ByteData byteData = await rootBundle.load(defaultImagePath);
    Uint8List defaultImageBytes = byteData.buffer.asUint8List();
    return await StoreDate().uploadImageToStorage(defaultImageBytes, context);
  }
}
