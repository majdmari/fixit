import 'dart:typed_data';

import 'package:flutter/material.dart';

class RegisterInfo {
  String? selectedOption;
  String? selectedGender;
  String? email;
  String? password;
  String? fullName;
  String? phoneNumber;
  String? birthOfDate;
  String? selectedCity;
  String? address;
  String? category;
  String? desc;
  Uint8List? selectedImage;
  String? imageFileName;

  RegisterInfo(
      {this.selectedOption,
      this.selectedGender,
      this.email,
      this.password,
      this.fullName,
      this.phoneNumber,
      this.birthOfDate,
      this.selectedCity,
      this.address,
      this.category,
      this.desc,
      this.selectedImage,
      this.imageFileName});
}

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
}
