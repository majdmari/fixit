// import 'package:fixit/constants.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class WriteReviewScreen extends StatelessWidget {
//   String? Cate;

//    WriteReviewScreen({Key? key,})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KSurface,
//       appBar: AppBar(
//           elevation: 0,
//           backgroundColor: KSurface,
//           title: Center(
//               child: Text(
//             'Write a  review',
//             style: TextStyle(fontFamily: 'Playfair Display'),
//           ))),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Rate This $Cate',
//                   textAlign: TextAlign.right,
//                   style: TextStyle(
//                     color: KWhite,
//                     fontFamily: 'Playfair Display',
//                   ),
//                 ),
//               ],
//             ),
//             Text('Tell others what you think',
//                 style: TextStyle(
//                     color: Colors.grey, fontFamily: 'Playfair Display'))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:fixit/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriteReviewScreen extends StatelessWidget {
  WriteReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KSurface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KSurface,
        title: Center(
          child: Text(
            'Write a review',
            style: TextStyle(fontFamily: 'Playfair Display'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tradepersons')
              .doc('salam@gmail.com') // Replace with your document ID
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return Text('No data available');
            }

            var data = snapshot.data!.data() as Map<String, dynamic>?;

            if (data == null || !data.containsKey('Category')) {
              return Text('Category not found');
            }

            String? cate = data['Category'];

            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Rate This $cate', // Display the value of category here
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: KWhite,
                        fontFamily: 'Playfair Display',
                      ),
                    ),
                  ],
                ),
                Text('Tell others what you think',
                    style: TextStyle(
                        color: Colors.grey, fontFamily: 'Playfair Display'))
              ],
            );
          },
        ),
      ),
    );
  }
}
