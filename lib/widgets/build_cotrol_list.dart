import 'package:fixit/widgets/control_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildCotrolList extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;
  final VoidCallback onDeletePressed;
  const BuildCotrolList(
      {Key? key, required this.userDocument, required this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0Xff2B2831),
        ),
        height: 120,
        child: ControlInfo(
          userDocument: userDocument,
          onDeletePressed: onDeletePressed,
        ),
      ),
    );
  }
}
