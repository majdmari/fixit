import 'package:fixit/widgets/fav_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildlistFav extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;
  final VoidCallback onRemove;

  const BuildlistFav(
      {Key? key, required this.userDocument, required this.onRemove})
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
        child: FavInfo(userDocument: userDocument, onRemove: onRemove),
      ),
    );
  }
}
