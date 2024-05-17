import 'package:fixit/constants.dart';
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
              color: KSurface,
            ),
            child: ReviewInfo(userDocument: userDocument),
          ),
        ),
        // Add space between comments
      ],
    );
  }
}
