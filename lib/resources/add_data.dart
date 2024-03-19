import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fixit/screens/register/user_model.dart';

class StoreDate {
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, BuildContext context) async {
    final registerInfo = Provider.of<RegisterViewModel>(context, listen: false);
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images/${registerInfo.emailController.text}/$childName');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}


  // Future<String> saveDate({
  //   required String name,
  //   required String bio,
  //   required Uint8List file,
  // }) async {
  //   String resp = 'Some error occured';
  //   try {
  //     if (name.isNotEmpty || bio.isNotEmpty) {
  //       String imageUrl = await uploadImageToStorage(name, file);
  //       await _firestore.collection('userPrifile').add({
  //         'name': name,
  //         'bio': bio,
  //         'imageLink': imageUrl,
  //       });
  //       resp = 'success';
  //     }
  //   } catch (err) {
  //     resp = err.toString();
  //   }
  //   return resp;
  // }

