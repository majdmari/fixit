// import 'package:fixit/constants.dart';
// import 'package:fixit/widgets/custom_drop_down.dart';
// import 'package:fixit/widgets/info.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TradepersonListScreen extends StatefulWidget {
//   static String id = 'TradepersonListScreen';

//   @override
//   State<TradepersonListScreen> createState() => _TradepersonListScreenState();
// }

// class _TradepersonListScreenState extends State<TradepersonListScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Color(0Xff000000),
//         appBar: AppBar(
//           backgroundColor: Colors.orange,
// title: Text('Comments'),
//         ),
//         body: Column(
//           children: [

//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('tradepersons')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return Center(
//                       child: Text('No data available'),
//                     );
//                   }
//                   final users = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       final userDocument = users[index];

//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 30),
//                           child: Column(
//                             children: [
//                               FutureBuilder<QuerySnapshot>(
//                                 future: FirebaseFirestore.instance
//                                     .collection('tradepersons')
//                                     .doc(userDocument.id)
//                                     .collection('info')
//                                     .get(),
//                                 builder: (BuildContext context,
//                                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return CircularProgressIndicator();
//                                   } else if (snapshot.hasError) {
//                                     return Text('Error: ${snapshot.error}');
//                                   } else {
//                                     final subCollectionDocs =
//                                         snapshot.data!.docs;
//                                     if (subCollectionDocs.isEmpty) {
//                                       return Text('No data available');
//                                     } else {
//                                       // Assuming you want to display the first document's data from the sub-collection
//                                       final userDocumentFromSubCollection =
//                                           subCollectionDocs[0];
//                                       return Info(
//                                           userDocument:
//                                               userDocumentFromSubCollection);
//                                     }
//                                   }
//                                 },
//                               ),
//                               if (index < users.length - 1) SizedBox(height: 8),
//                             ],
//                           ),
//                         );

//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/widgets/info.dart';

// class ReviewListScreen extends StatelessWidget {
//   ReviewListScreen({required this.email});
//   static String id = 'ReviewListScreen';
//   String email;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0Xff000000),
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text('Comments'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('tradepersons')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(child: Text('No data available'));
//                 }
//                 final users = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     final userDocument = users[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: Column(
//                         children: [
//                           FutureBuilder<QuerySnapshot>(
//                             future: FirebaseFirestore.instance
//                                 .collection('tradepersons')
//                                 .doc(userDocument.id)
//                                 .collection('info')
//                                 .get(),
//                             builder: (BuildContext context,
//                                 AsyncSnapshot<QuerySnapshot> snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text('Error: ${snapshot.error}');
//                               } else {
//                                 final subCollectionDocs = snapshot.data!.docs;
//                                 if (subCollectionDocs.isEmpty) {
//                                   return Text('No data available');
//                                 } else {
//                                   // Assuming you want to display the first document's data from the sub-collection
//                                   final userDocumentFromSubCollection =
//                                       subCollectionDocs[0];
//                                   return Info(
//                                       userDocument:
//                                           userDocumentFromSubCollection);
//                                 }
//                               }
//                             },
//                           ),
//                           if (index < users.length - 1) SizedBox(height: 8),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:fixit/constants.dart';
import 'package:fixit/widgets/build_list_review.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/widgets/buildlistitem.dart';

class ReviewListScreen extends StatelessWidget {
  ReviewListScreen({required this.email});
  static String id = 'ReviewListScreen';
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KSurface,
      appBar: AppBar(
        backgroundColor: KSecondary,
        title: Text(
          'Comments',
          style: TextStyle(fontFamily: Kword),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Comments')
            .doc(email) // Assuming the email is the document ID
            .collection('Comment')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              'No comments available',
              style: TextStyle(color: Colors.white),
            ));
          }
          final comments = snapshot.data!.docs;
          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final commentDocument = comments[index];
              return BuildlistReview(userDocument: commentDocument);
            },
          );
        },
      ),
    );
  }
}
