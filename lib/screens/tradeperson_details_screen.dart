// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';

// class TradepersonDetailsScreen extends StatefulWidget {
//   static String id = 'TradepersonShowToUserScreen';

//   final String fullName;
//   final String city;
//   final String birthDate;
//   final String status;
//   final String email;
//   final String description;
//   final String category;
//   final String adress;

//   final String imageUrl; // Add imageUrl to display image

//   TradepersonDetailsScreen({
//     required this.fullName,
//     required this.city,
//     required this.birthDate,
//     required this.status,
//     required this.email,
//     required this.description,
//     required this.imageUrl,
//     required this.category,
//     required this.adress,
//   });

//   @override
//   State<TradepersonDetailsScreen> createState() =>
//       _TradepersonDetailsScreenState();
// }

// class _TradepersonDetailsScreenState extends State<TradepersonDetailsScreen> {
//   bool isFavorite = false; // Track favorite status

//   @override
//   void initState() {
//     super.initState();
//     checkFavorite();
//   }

//   void checkFavorite() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       String userEmail = user.email ?? "";
//       DocumentSnapshot<
//           Map<String,
//               dynamic>> favoriteSnapshot = await FirebaseFirestore.instance
//           .collection('favorites')
//           .doc(userEmail)
//           .collection('favoriteList')
//           .doc(widget
//               .email) // Assuming the tradeperson's email is used as the document ID
//           .get();
//       setState(() {
//         isFavorite = favoriteSnapshot.exists;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Profile',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface,
//       body: Padding(
//         padding: EdgeInsets.all(30),
//         child: ListView(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 10),
//                 Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 70,
//                       backgroundColor: Colors.white,
//                       child: CircleAvatar(
//                         backgroundImage: NetworkImage(widget.imageUrl),
//                         radius: 68,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   widget.fullName,
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//                 Text(
//                   widget.category,
//                   style: TextStyle(color: Colors.grey, fontSize: 20),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Email:  ${widget.email} ",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),

//                 SizedBox(height: 15),
//                 Text(
//                   "City : ${widget.city}",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),

//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "Adress : ${widget.adress}",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),

//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "BirthDay : ${widget.birthDate}",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),

//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.star,
//                       color: Colors.white,
//                     ),
//                     Text(
//                       "4.7●",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18),
//                     ),
//                     GestureDetector(
//                       child: Text(
//                         "1,399 review",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             decoration: TextDecoration.underline),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 15),
//                 Expanded(
//                   child: Text(
//                     widget.description,
//                     style: TextStyle(fontSize: 13, color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   'Status : ${widget.status}',
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),

//                 SizedBox(height: 15),

//                 Divider(
//                   thickness: 2,
//                   color: KSecondary,
//                   height: 10,
//                 ),
//                 SizedBox(height: 15),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Rate this ${widget.category} :',
//                         style: TextStyle(color: Colors.white, fontSize: 17),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Tell others what you think',
//                         style: TextStyle(color: Colors.grey, fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 20),

//                 Divider(
//                   thickness: 2,
//                   color: KSecondary,
//                   height: 10,
//                 ),
//                 // Add favorite button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.call,
//                         size: 60,
//                         color: KSecondary,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: toggleFavorite,
//                       icon: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : KSecondary,
//                         size: 60,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to toggle favorite status
//   void toggleFavorite() async {
//     User? user = FirebaseAuth.instance.currentUser; // Get current user
//     if (user != null) {
//       String userEmail = user.email ?? ""; // Get current user's email

//       setState(() {
//         isFavorite = !isFavorite;
//       });

//       if (isFavorite) {
//         // Add to favorites in Firebase
//         await FirebaseFirestore.instance
//             .collection('favorites')
//             .doc(userEmail)
//             .collection('favoriteList')
//             .doc(widget
//                 .email) // Assuming the tradeperson's email is used as the document ID
//             .set({
//           'FullName': widget.fullName,
//           'ImageLink': widget.imageUrl,
//           'City': widget.city,
//           'Email': widget.email,
//           'Desc': widget.description,
//           'Category': widget.category,
//           'Status': widget.status,
//           'BirthOfDate': widget.birthDate,
//           // Add other tradeperson details as needed
//         });
//       } else {
//         // Remove from favorites in Firebase
//         await FirebaseFirestore.instance
//             .collection('favorites')
//             .doc(userEmail)
//             .collection('favoriteList')
//             .doc(widget
//                 .email) // Assuming the tradeperson's email is used as the document ID
//             .delete();
//       }
//     }
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fixit/constants.dart';
// import 'package:fixit/screens/review_list_screen.dart';
// import 'package:fixit/screens/user_writeReview_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// class TradepersonDetailsScreen extends StatefulWidget {
//   static String id = 'TradepersonShowToUserScreen';

//   final String fullName;
//   final String city;
//   final String birthDate;
//   final String status;
//   final String email;
//   final String description;
//   final String category;
//   final String adress;
//   final String phoneNumber;

//   final String imageUrl; // Add imageUrl to display image

//   TradepersonDetailsScreen({
//     required this.fullName,
//     required this.city,
//     required this.birthDate,
//     required this.status,
//     required this.email,
//     required this.description,
//     required this.imageUrl,
//     required this.category,
//     required this.adress,
//     required this.phoneNumber,
//   });

//   @override
//   State<TradepersonDetailsScreen> createState() =>
//       _TradepersonDetailsScreenState();
// }

// class _TradepersonDetailsScreenState extends State<TradepersonDetailsScreen> {
//   bool isFavorite = false; // Track favorite status
//   double totalRating = 0; // Variable to store total rating
//   int reviewsNumber = 0; // Variable to store number of reviews

//   @override
//   void initState() {
//     super.initState();
//     checkFavorite();
//     fetchTradePersonDetails();
//   }

//   void fetchTradePersonDetails() async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> tradePersonSnapshot =
//           await FirebaseFirestore.instance
//               .collection('tradepersons')
//               .doc(widget.email) // Assuming email is the document ID
//               .get();

//       if (tradePersonSnapshot.exists) {
//         setState(() {
//           totalRating = tradePersonSnapshot.get('TotalRating') ?? 0;
//           reviewsNumber = tradePersonSnapshot.get('ReviewsNumber') ?? 0;
//         });
//       }
//     } catch (error) {
//       print('Error fetching trade person details: $error');
//     }
//   }

//   void checkFavorite() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       String userEmail = user.email ?? "";
//       DocumentSnapshot<
//           Map<String,
//               dynamic>> favoriteSnapshot = await FirebaseFirestore.instance
//           .collection('favorites')
//           .doc(userEmail)
//           .collection('favoriteList')
//           .doc(widget
//               .email) // Assuming the tradeperson's email is used as the document ID
//           .get();
//       setState(() {
//         isFavorite = favoriteSnapshot.exists;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double averageRating = reviewsNumber != 0 ? totalRating / reviewsNumber : 0;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Profile',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface,
//       body: Padding(
//         padding: EdgeInsets.all(30),
//         child: ListView(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 10),
//                 Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 70,
//                       backgroundColor: Colors.white,
//                       child: CircleAvatar(
//                         backgroundImage: NetworkImage(widget.imageUrl),
//                         radius: 68,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   widget.fullName,
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//                 Text(
//                   widget.category,
//                   style: TextStyle(color: Colors.grey, fontSize: 20),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Email:  ${widget.email} ",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   "City : ${widget.city}",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),

//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "Adress : ${widget.adress}",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "BirthDay : ${widget.birthDate}",
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),

//                 SizedBox(height: 15),
//                 Text(
//                   'Status : ${widget.status}',
//                   style: TextStyle(color: Colors.white, fontSize: 17),
//                 ),
//                 SizedBox(height: 15),
//                 Divider(
//                   thickness: 2,
//                   color: Colors.grey,
//                   height: 10,
//                 ),
//                 SizedBox(height: 15),

//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         widget.description,
//                         style: TextStyle(fontSize: 13, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 15),

//                 Divider(
//                   thickness: 2,
//                   color: Colors.grey,
//                   height: 10,
//                 ),
//                 SizedBox(height: 15),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Rate this ${widget.category} :',
//                         style: TextStyle(color: Colors.white, fontSize: 17),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Tell others what you think',
//                         style: TextStyle(color: Colors.grey, fontSize: 12),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => WriteReviewScreen(
//                                 category: widget.category,
//                                 email: widget.email,
//                               ),
//                             ),
//                           );
//                         },
//                         icon: Icon(
//                           Icons.star_rate,
//                           color: Colors.white,
//                           size: 50,
//                         )),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.star,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           averageRating.toString() + " ●",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18),
//                         ),
//                         GestureDetector(
//                           child: Text(
//                             reviewsNumber.toString() + ' review',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 decoration: TextDecoration.underline),
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ReviewListScreen(
//                                   email: widget.email,
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),

//                 Divider(
//                   thickness: 2,
//                   color: Colors.grey,
//                   height: 10,
//                 ),
//                 SizedBox(height: 20),
//                 // Add favorite button

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         FlutterPhoneDirectCaller.callNumber(widget.phoneNumber);
//                       },
//                       icon: Icon(
//                         Icons.call,
//                         size: 60,
//                         color: KSecondary,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: toggleFavorite,
//                       icon: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : KSecondary,
//                         size: 60,
//                       ),
//                     ),
//                     SizedBox(height: 100),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to toggle favorite status
//   void toggleFavorite() async {
//     User? user = FirebaseAuth.instance.currentUser; // Get current user
//     if (user != null) {
//       String userEmail = user.email ?? ""; // Get current user's email

//       setState(() {
//         isFavorite = !isFavorite;
//       });

//       if (isFavorite) {
//         // Add to favorites in Firebase
//         await FirebaseFirestore.instance
//             .collection('favorites')
//             .doc(userEmail)
//             .collection('favoriteList')
//             .doc(widget
//                 .email) // Assuming the tradeperson's email is used as the document ID
//             .set({
//           'FullName': widget.fullName,
//           'ImageLink': widget.imageUrl,
//           'City': widget.city,
//           'Email': widget.email,
//           'Desc': widget.description,
//           'Category': widget.category,
//           'Status': widget.status,
//           'BirthOfDate': widget.birthDate,
//           // Add other tradeperson details as needed
//         });
//       } else {
//         // Remove from favorites in Firebase
//         await FirebaseFirestore.instance
//             .collection('favorites')
//             .doc(userEmail)
//             .collection('favoriteList')
//             .doc(widget
//                 .email) // Assuming the tradeperson's email is used as the document ID
//             .delete();
//       }
//     }
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fixit/constants.dart';
// import 'package:fixit/screens/review_list_screen.dart';
// import 'package:fixit/screens/user_writeReview_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// class TradepersonDetailsScreen extends StatefulWidget {
//   static String id = 'TradepersonShowToUserScreen';

//   final String fullName;
//   final String city;
//   final String birthDate;
//   final String status;
//   final String email;
//   final String description;
//   final String category;
//   final String adress;
//   final String phoneNumber;
//   final String imageUrl;

//   TradepersonDetailsScreen({
//     required this.fullName,
//     required this.city,
//     required this.birthDate,
//     required this.status,
//     required this.email,
//     required this.description,
//     required this.imageUrl,
//     required this.category,
//     required this.adress,
//     required this.phoneNumber,
//   });

//   @override
//   State<TradepersonDetailsScreen> createState() =>
//       _TradepersonDetailsScreenState();
// }

// class _TradepersonDetailsScreenState extends State<TradepersonDetailsScreen> {
//   bool isFavorite = false;

//   @override
//   void initState() {
//     super.initState();
//     checkFavorite();
//   }

//   void checkFavorite() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       String userEmail = user.email ?? "";
//       DocumentSnapshot<Map<String, dynamic>> favoriteSnapshot =
//           await FirebaseFirestore.instance
//               .collection('favorites')
//               .doc(userEmail)
//               .collection('favoriteList')
//               .doc(widget.email)
//               .get();
//       setState(() {
//         isFavorite = favoriteSnapshot.exists;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Profile',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface,
//       body: Padding(
//         padding: EdgeInsets.all(30),
//         child: StreamBuilder<DocumentSnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('tradepersons')
//               .doc(widget.email)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }

//             var tradePersonData = snapshot.data!.data() as Map<String, dynamic>;
//             double totalRating =
//                 (tradePersonData['TotalRating'] ?? 0).toDouble();
//             int reviewsNumber = tradePersonData['ReviewsNumber'] ?? 0;
//             double averageRating =
//                 reviewsNumber != 0 ? totalRating / reviewsNumber : 0;

//             return ListView(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 10),
//                     Stack(
//                       children: [
//                         CircleAvatar(
//                           radius: 70,
//                           backgroundColor: Colors.white,
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(widget.imageUrl),
//                             radius: 68,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       widget.fullName,
//                       style: TextStyle(color: Colors.white, fontSize: 25),
//                     ),
//                     Text(
//                       widget.category,
//                       style: TextStyle(color: Colors.grey, fontSize: 20),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Email:  ${widget.email} ",
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       "City : ${widget.city}",
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       "Address : ${widget.adress}",
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       "BirthDay : ${widget.birthDate}",
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       'Status : ${widget.status}',
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                     SizedBox(height: 15),
//                     Divider(
//                       thickness: 2,
//                       color: Colors.grey,
//                       height: 10,
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             widget.description,
//                             style: TextStyle(fontSize: 13, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Divider(
//                       thickness: 2,
//                       color: Colors.grey,
//                       height: 10,
//                     ),
//                     SizedBox(height: 15),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Rate this ${widget.category} :',
//                             style: TextStyle(color: Colors.white, fontSize: 17),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Tell others what you think',
//                             style: TextStyle(color: Colors.grey, fontSize: 12),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => WriteReviewScreen(
//                                   category: widget.category,
//                                   email: widget.email,
//                                 ),
//                               ),
//                             );
//                           },
//                           icon: Icon(
//                             Icons.star_rate,
//                             color: Colors.white,
//                             size: 50,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               color: Colors.white,
//                             ),
//                             Text(
//                               averageRating.toStringAsFixed(1) + ' ●',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18),
//                             ),
//                             GestureDetector(
//                               child: Text(
//                                 reviewsNumber.toString() + ' review',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                     decoration: TextDecoration.underline),
//                               ),
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ReviewListScreen(
//                                       email: widget.email,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Divider(
//                       thickness: 2,
//                       color: Colors.grey,
//                       height: 10,
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             FlutterPhoneDirectCaller.callNumber(
//                                 widget.phoneNumber);
//                           },
//                           icon: Icon(
//                             Icons.call,
//                             size: 60,
//                             color: KSecondary,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: toggleFavorite,
//                           icon: Icon(
//                             isFavorite ? Icons.favorite : Icons.favorite_border,
//                             color: isFavorite ? Colors.red : KSecondary,
//                             size: 60,
//                           ),
//                         ),
//                         SizedBox(height: 100),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void toggleFavorite() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       String userEmail = user.email ?? "";
//       setState(() {
//         isFavorite = !isFavorite;
//       });
//       if (isFavorite) {
//         await FirebaseFirestore.instance
//             .collection('favorites')
//             .doc(userEmail)
//             .collection('favoriteList')
//             .doc(widget.email)
//             .set({
//           'FullName': widget.fullName,
//           'ImageLink': widget.imageUrl,
//           'City': widget.city,
//           'Email': widget.email,
//           'Desc': widget.description,
//           'Category': widget.category,
//           'Status': widget.status,
//           'BirthOfDate': widget.birthDate,
//           'PhoneNumber': widget.phoneNumber,
//           'Address': widget.adress,
//         });
//       } else {
//         await FirebaseFirestore.instance
//             .collection('favorites')
//             .doc(userEmail)
//             .collection('favoriteList')
//             .doc(widget.email)
//             .delete();
//       }
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/review_list_screen.dart';
import 'package:fixit/screens/user_writeReview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class TradepersonDetailsScreen extends StatefulWidget {
  static String id = 'TradepersonShowToUserScreen';

  final String email;

  TradepersonDetailsScreen({
    required this.email,
  });

  @override
  State<TradepersonDetailsScreen> createState() =>
      _TradepersonDetailsScreenState();
}

class _TradepersonDetailsScreenState extends State<TradepersonDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  void checkFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? "";
      DocumentSnapshot<Map<String, dynamic>> favoriteSnapshot =
          await FirebaseFirestore.instance
              .collection('favorites')
              .doc(userEmail)
              .collection('favoriteList')
              .doc(widget.email)
              .get();
      setState(() {
        isFavorite = favoriteSnapshot.exists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontFamily: Kword),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tradepersons')
              .doc(widget.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var tradePersonData = snapshot.data!.data() as Map<String, dynamic>;
            double totalRating =
                (tradePersonData['TotalRating'] ?? 0).toDouble();
            int reviewsNumber = tradePersonData['ReviewsNumber'] ?? 0;
            double averageRating =
                reviewsNumber != 0 ? totalRating / reviewsNumber : 0;
            // Update AverageRating in tradepersons collection
            updateAverageRating(averageRating);

            return ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(tradePersonData['ImageLink']),
                            radius: 68,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      tradePersonData['FullName'],
                      style: TextStyle(
                          color: Colors.white, fontSize: 25, fontFamily: Kword),
                    ),
                    Text(
                      tradePersonData['Category'],
                      style: TextStyle(
                          color: Colors.grey, fontSize: 20, fontFamily: Kword),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Email:  ${widget.email} ",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "City : ${tradePersonData['City']}",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Address : ${tradePersonData['Address']}",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "BirthDay : ${tradePersonData['BirthOfDate']}",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Status : ${tradePersonData['Status']}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                      height: 10,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tradePersonData['Description'],
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: Kword),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                      height: 10,
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rate this ${tradePersonData['Category']} :',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: Kword),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tell others what you think',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: Kword),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          child: Row(
                            children: [
                              Text(
                                'Rate Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.rate_review,
                                color: Colors.white,
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WriteReviewScreen(
                                  category: tradePersonData['Category'],
                                  email: widget.email,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            Text(
                              averageRating.toStringAsFixed(2) + ' ● ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            GestureDetector(
                              child: Text(
                                reviewsNumber.toString() + ' review',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewListScreen(
                                      email: widget.email,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.comment,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                      height: 10,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            FlutterPhoneDirectCaller.callNumber(
                                tradePersonData['PhoneNumber']);
                          },
                          icon: Icon(
                            Icons.call,
                            size: 60,
                            color: KSecondary,
                          ),
                        ),
                        IconButton(
                          onPressed: toggleFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : KSecondary,
                            size: 60,
                          ),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? "";
      setState(() {
        isFavorite = !isFavorite;
      });
      if (isFavorite) {
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(userEmail)
            .collection('favoriteList')
            .doc(widget.email)
            .set({
          'Email': widget.email,
        });
      } else {
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(userEmail)
            .collection('favoriteList')
            .doc(widget.email)
            .delete();
      }
    }
  }

  void updateAverageRating(double averageRating) async {
    // Get a reference to the document in the 'tradepersons' collection
    DocumentReference tradePersonRef =
        FirebaseFirestore.instance.collection('tradepersons').doc(widget.email);

    // Update the document with the new averageRating
    await tradePersonRef.update({'AverageRating': averageRating});
  }
}
