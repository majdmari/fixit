import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_alert_message.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomPopUpDialog extends StatelessWidget {
  CustomPopUpDialog(
      {required this.text,
      required this.label,
      this.hintText,
      required this.onSave,
      this.keyboardType,
      required this.message});
  String text;
  String label;
  String? hintText;
  VoidCallback? onTap;
  final Function(String) onSave;
  TextInputType? keyboardType;
  String message;

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    return AlertDialog(
      backgroundColor: KSurface,
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomTextField(
              label: label,
              hintText: hintText,
              controller: textFieldController,
              keyboardType: keyboardType,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CustomButton(
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          text: 'Cancel',
        ),
        CustomButton(
          onTap: () {
            final newValue = textFieldController.text.trim();
            if (newValue.isNotEmpty) {
              onSave(newValue); // Save the new value
              Navigator.of(context).pop(); // Close the dialog
            } else {
              showCustomDialog(context, message);
            }
          },
          text: 'Save',
        ),
      ],
    );
  }

  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(message: message);
      },
    );
  }
}

class ChangePasswordDialog extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final Function(String) onChangePassword;

  ChangePasswordDialog({required this.onChangePassword});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: KSurface,
      title: Text('Change Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: _oldPasswordController,
            label: 'Old Password',
            hintText: 'Enter your old password',
            obscureText: true,
            icon: Icons.lock,
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: _newPasswordController,
            label: 'New Password',
            hintText: 'Enter your new password',
            obscureText: true,
            icon: Icons.lock,
          ),
        ],
      ),
      actions: [
        CustomButton(
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          text: 'Cancel',
        ),
        CustomButton(
          onTap: () async {
            String oldPassword = _oldPasswordController.text.trim();
            String newPassword = _newPasswordController.text.trim();
            if (oldPassword.isEmpty && newPassword.isEmpty) {
              // Show an alert message if both old password and new password are empty
              showCustomDialog(
                  context, 'Both old and new passwords cannot be empty.');
            } else if (oldPassword.isEmpty) {
              // Show an alert message if the old password is empty
              showCustomDialog(context, 'Old passwords cannot be empty.');
            } else if (newPassword.isEmpty) {
              // Show an alert message if the new password is empty
              showCustomDialog(context, 'New passwords cannot be empty.');
            } else {
              // Check if the old password matches the password stored in Firestore
              bool isOldPasswordCorrect = await checkOldPassword(oldPassword);
              if (!isOldPasswordCorrect) {
                // Show an error message if the old password is incorrect
                showCustomDialog(context, "The old password is incorrect");
              } else {
                // Call the callback function to change password
                if (newPassword.isNotEmpty) {
                  onChangePassword(newPassword);
                }

                Navigator.of(context).pop();
              }
            } // Close the dialog
          },
          text: 'Change',
        ),
      ],
    );
  }

  Future<bool> checkOldPassword(String oldPassword) async {
    try {
      // Get the current user's email
      String userEmail = FirebaseAuth.instance.currentUser!.email!;

      // Query Firestore to get the user document
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .get();

      // Retrieve the stored password from the user document
      String storedPassword = userSnapshot['Password'];

      // Compare the stored password with the entered old password
      return oldPassword == storedPassword;
    } catch (e) {
      // Handle any errors that occur during the process
      print("Error checking old password: $e");
      return false;
    }
  }

  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(message: message);
      },
    );
  }
}
