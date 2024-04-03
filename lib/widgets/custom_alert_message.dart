import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;

  const CustomAlertDialog({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: KSurface,
      title: Text(
        'Error',
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
