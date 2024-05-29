import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.onChanged,
      this.hintText,
      this.obscureText = false,
      this.icon,
      required this.label,
      this.keyboardType,
      this.controller,
      this.validator,
      this.inputFormatters});
  IconData? icon;
  String? hintText;
  String label;
  bool? obscureText;
  Function(String)? onChanged;
  TextEditingController? controller;
  TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText!,
      validator: validator ??
          (data) {
            if (data!.isEmpty) {
              return 'Field is required';
            }
          },
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(color: Colors.grey, fontFamily: Kword),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontFamily: Kword),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: KSf2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: KSf2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: KSecondary,
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            icon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
