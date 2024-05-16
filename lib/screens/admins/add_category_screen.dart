import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key});
  static String id = 'AddCategory';

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? category;
  Uint8List? selectedImage;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Category',
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
                        child: selectedImage != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(selectedImage!),
                                radius: 68,
                              )
                            : CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/category_pic.png'),
                                radius: 68,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        category = value;
                      },
                      hintText: 'Type the Category name here',
                      label: 'Category',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                      text: 'Done',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (category == null) {
                            showCustomDialog(
                                context, "You can't leave Category empty.");
                            return;
                          }

                          isLoading = true;
                          setState(() {});
                          String ImageUrl = '';
                          if (selectedImage != null) {
                            ImageUrl = await uploadImageToStorage(
                                selectedImage!, context);
                          } else {
                            ImageUrl = await _uploadDefaultImage(
                                'assets/images/category_pic.png', context);
                          }

                          try {
                            await FirebaseFirestore.instance
                                .collection('Categorys')
                                .doc(category)
                                .set({
                              'Category': category,
                              'ImageLink': ImageUrl,
                            });

                            showSnackBar(context, 'Success');
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

  // Future<void> addTradeperson() async {
  //   UserCredential user = await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //           email: TradeEmail!, password: registerInfo.password!);
  // }

  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(message: message);
      },
    );
  }

  Future<String> uploadImageToStorage(
      Uint8List file, BuildContext context) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('Categorys/$category/${DateTime.now()}');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _pickImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path).readAsBytesSync();
      });
    }
  }

  Future<String> _uploadDefaultImage(
      String defaultImagePath, BuildContext context) async {
    ByteData byteData = await rootBundle.load(defaultImagePath);
    Uint8List defaultImageBytes = byteData.buffer.asUint8List();
    return await uploadImageToStorage(defaultImageBytes, context);
  }
}
