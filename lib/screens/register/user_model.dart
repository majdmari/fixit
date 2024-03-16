import 'package:flutter/material.dart';

class RegisterInfo {
  String? selectedOption;
  String? selectedGender;
  String? userName;
  String? email;
  String? password;
  String? fullName;
  String? phoneNumber;
  String? birthOfDate;
  String? selectedCity;
  String? address;
  String? category;
  String? desc;
  TextEditingController? controller;

  RegisterInfo(
      {this.selectedOption,
      this.selectedGender,
      this.userName,
      this.email,
      this.password,
      this.fullName,
      this.phoneNumber,
      this.birthOfDate,
      this.selectedCity,
      this.address,
      this.category,
      this.desc,
      this.controller});
}

// import 'package:flutter/material.dart';

// class RegisterInfo {
//   String? selectedOption;
//   String? selectedGender;
//   String? userName;
//   String? email;
//   String? password;
//   String? fullName;
//   String? phoneNumber;
//   String? birthOfDate;
//   String? selectedCity;
//   String? address;
//   String? category;
//   String? desc;

//   // Constructor with named parameters
//   RegisterInfo({
//     this.selectedOption,
//     this.selectedGender,
//     this.userName,
//     this.email,
//     this.password,
//     this.fullName,
//     this.phoneNumber,
//     this.birthOfDate,
//     this.selectedCity,
//     this.address,
//     this.category,
//     this.desc,
//   });

//   // Factory constructor for creating an instance of RegisterInfo
//   // from a map
//   factory RegisterInfo.fromMap(Map<String, dynamic> map) {
//     return RegisterInfo(
//       selectedOption: map['selectedOption'],
//       selectedGender: map['selectedGender'],
//       userName: map['userName'],
//       email: map['email'],
//       password: map['password'],
//       fullName: map['fullName'],
//       phoneNumber: map['phoneNumber'],
//       birthOfDate: map['birthOfDate'],
//       selectedCity: map['selectedCity'],
//       address: map['address'],
//       category: map['category'],
//       desc: map['desc'],
//     );
//   }

//   // Method to convert RegisterInfo instance to a map
//   Map<String, dynamic> toMap() {
//     return {
//       'selectedOption': selectedOption,
//       'selectedGender': selectedGender,
//       'userName': userName,
//       'email': email,
//       'password': password,
//       'fullName': fullName,
//       'phoneNumber': phoneNumber,
//       'birthOfDate': birthOfDate,
//       'selectedCity': selectedCity,
//       'address': address,
//       'category': category,
//       'desc': desc,
//     };
//   }
// }
