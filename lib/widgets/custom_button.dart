import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onTap, required this.text});

  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: KSecondary,
          borderRadius: BorderRadius.circular(8),
        ),
        // width: double.infinity,
        // height: 60,
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.05,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
