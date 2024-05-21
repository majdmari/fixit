// import 'package:flutter/material.dart';
// import 'info.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Buildlistitem extends StatelessWidget {
//   final QueryDocumentSnapshot userDocument;

//   const Buildlistitem({Key? key, required this.userDocument}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0Xff2B2831),
//         ),
//         height: 100,
//         child: Info(userDocument: userDocument),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Buildlistitem extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;

  const Buildlistitem({Key? key, required this.userDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0Xff2B2831),
        ),
        height: 120,
        child: Info(userDocument: userDocument),
      ),
    );
  }
}
