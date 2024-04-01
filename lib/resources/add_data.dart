// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:fixit/screens/register/user_model.dart';

// class StoreDate {
//   Future<String> uploadImageToStorage(
//       String childName, Uint8List file, BuildContext context) async {
//     final registerInfo = Provider.of<RegisterViewModel>(context, listen: false);
//     Reference ref = FirebaseStorage.instance
//         .ref()
//         .child('images/${registerInfo.emailController.text}/$childName');
//     UploadTask uploadTask = ref.putData(file);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
// }

import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fixit/screens/register/user_model.dart';

class StoreDate {
  Future<String> uploadImageToStorage(
      Uint8List file, BuildContext context) async {
    final registerInfo = Provider.of<RegisterViewModel>(context, listen: false);
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images/${registerInfo.emailController.text}/${DateTime.now()}');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
