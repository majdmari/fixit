import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final String? title;

  const CustomAlertDialog({
    required this.message,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: KSurface,
      title: Text(
        title ?? "Error",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(
        message,
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
  }
}
