import 'dart:io';

import 'package:fixit/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart'; // Import rating bar package

class WriteReviewScreen extends StatefulWidget {
  static String id = 'write_review_screen';
  WriteReviewScreen({Key? key}) : super(key: key);

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  File? _image;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

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
        child: SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        'Rate This $cate', // Display the value of category here
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: KWhite,
                          fontFamily: 'Playfair Display',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tell others what you think',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Playfair Display',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 35,
                      itemPadding: EdgeInsets.symmetric(horizontal: 18),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {
                        // Update the rating
                        print(rating);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Write something...', // نص التلميح
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Playfair Display',
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: KSurface,
                    ),
                    maxLines: 10, // عدد الأسطر المسموح كتابتها
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _getImageFromGallery,
                    icon: Icon(
                      Icons.upload,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'Upload Your Image',
                      style: TextStyle(color: Colors.grey),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: KSurface,
                      onPrimary: KSf2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  SizedBox(height: 190),
                  ElevatedButton(
                    onPressed: () {
                      // هنا يمكنك وضع الكود الخاص بنشر التعليق
                      // مثال: إرسال التعليق إلى قاعدة البيانات
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Playfair Display',
                          fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: KSecondary, // لون الزر
                        onPrimary: Colors.white, // لون النص داخل الزر
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // شكل الحواف
                        ),
                        minimumSize: Size(80, 60)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // هنا يمكنك وضع الكود الخاص بنشر التعليق
                      // مثال: إرسال التعليق إلى قاعدة البيانات
                    },
                    child: Text(
                      'Cancle',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Playfair Display',
                          fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: KSurface, // لون الزر
                        onPrimary: Colors.white, // لون النص داخل الزر
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // شكل الحواف
                        ),
                        elevation: 0,
                        minimumSize: Size(80, 60)),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}



// import 'package:fixit/constants.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class WriteReviewScreen extends StatelessWidget {
//   static String id = 'write_review_screen';
//   WriteReviewScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KSurface,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: KSurface,
//         title: Center(
//           child: Text(
//             'Write a review',
//             style: TextStyle(fontFamily: 'Playfair Display'),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: StreamBuilder<DocumentSnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('tradepersons')
//               .doc('salam@gmail.com') // Replace with your document ID
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             }

//             if (!snapshot.hasData) {
//               return Text('No data available');
//             }

//             var data = snapshot.data!.data() as Map<String, dynamic>?;

//             if (data == null || !data.containsKey('Category')) {
//               return Text('Category not found');
//             }

//             String? cate = data['Category'];

//             return Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Rate This $cate', // Display the value of category here
//                       textAlign: TextAlign.right,
//                       style: TextStyle(
//                         color: KWhite,
//                         fontFamily: 'Playfair Display',
//                         fontSize: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Tell  others  what  you  think',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontFamily: 'Playfair Display',
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
