import 'dart:typed_data';

import 'package:flutter/material.dart';

class RegisterInfo {
  String? selectedOption;
  String? selectedGender;
  String? email;
  String? password;
  String? confirmPassword;
  String? fullName;
  String? phoneNumber;
  String? birthOfDate;
  String? selectedCity;
  String? address;
  String? category;
  String? desc;
  Uint8List? selectedImage;
  String? imagePickerFire;
  String? selectedStatus;

  RegisterInfo(
      {this.selectedOption,
      this.selectedStatus,
      this.selectedGender,
      this.email,
      this.password,
      this.confirmPassword,
      this.fullName,
      this.phoneNumber,
      this.birthOfDate,
      this.selectedCity,
      this.address,
      this.category,
      this.desc,
      this.selectedImage,
      this.imagePickerFire});
}

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
}
