import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomPopUpDialog extends StatelessWidget {
  CustomPopUpDialog(
      {required this.text,
      required this.label,
      this.hintText,
      required this.onSave,
      this.keyboardType});
  String text;
  String label;
  String? hintText;
  VoidCallback? onTap;
  final Function(String) onSave;
  TextInputType? keyboardType;

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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: KSurface,
                    title: Text(
                      'Error',
                      style: TextStyle(color: Colors.red),
                    ),
                    content: Text(
                      'Text field cannot be empty.',
                      style: TextStyle(color: Colors.red),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          text: 'Save',
        ),
      ],
    );
  }
}

class ChangePasswordDialog extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
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
          //  CustomTextField(
          //   controller: _passwordController,
          //   label: 'Old Password',
          //   hintText: 'Enter your old password',
          //   obscureText: true,
          //   icon: Icons.lock,
          // ),
          CustomTextField(
            controller: _passwordController,
            label: 'New Password',
            hintText: 'Enter your new password',
            obscureText: false,
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
          onTap: () {
            String newPassword = _passwordController.text.trim();
            // Call the callback function to change password
            if (newPassword.isNotEmpty) {
              onChangePassword(newPassword);
            }

            Navigator.of(context).pop(); // Close the dialog
          },
          text: 'Change',
        ),
      ],
    );
  }
}
