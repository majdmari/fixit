import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriteReviewScreen extends StatelessWidget {
  final QueryDocumentSnapshot uDocument;

  const WriteReviewScreen({Key? key, required this.uDocument})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KSurface,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: KSurface,
          title: Center(
              child: Text(
            'Write a  review',
            style: TextStyle(fontFamily: 'Playfair Display'),
          ))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Rate This',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: KWhite,
                    fontFamily: 'Playfair Display',
                  ),
                ),
                Text(uDocument['Category'] ?? 'Unknown')
              ],
            ),
            Text('Tell others what you think',
                style: TextStyle(
                    color: Colors.grey, fontFamily: 'Playfair Display'))
          ],
        ),
      ),
    );
  }
}
