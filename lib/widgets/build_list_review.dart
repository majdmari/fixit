import 'package:fixit/widgets/review_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildlistReview extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;

  const BuildlistReview({Key? key, required this.userDocument})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0Xff2B2831),
            ),
            child: ReviewInfo(userDocument: userDocument),
          ),
        ),
        SizedBox(height: 10), // Add space between comments
      ],
    );
  }
}
