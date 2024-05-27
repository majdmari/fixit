// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/constants.dart';
// import '../widgets/buildlistitem.dart';
// import '../widgets/custom_drop_down.dart';

// class TradepersonListScreen extends StatefulWidget {
//   static String id = 'TradepersonListScreen';

//   @override
//   State<TradepersonListScreen> createState() => _TradepersonListScreenState();
// }

// class _TradepersonListScreenState extends State<TradepersonListScreen> {
//   String? selectedCity; // قيمة افتراضية ممكنة هي null
//   String? searchKeyword; // الكلمة المراد البحث عنها

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         title: TextField(
//           cursorColor: kPrimaryColor,
//           cursorHeight: 20,
//           style: TextStyle(color: Colors.white), // تعيين لون النص إلى الأبيض
//           onChanged: (value) {
//             setState(() {
//               searchKeyword = value;
//             });
//           },
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(42),
//             ),
//             hintText: 'Search by Name?',
//             hintStyle: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Playfair Display',
//             ),
//             filled: true,
//             fillColor: KSf2,
//             prefixIcon: Icon(Icons.search, color: Colors.white),
//             suffixIcon: IconButton(
//               icon: Icon(Icons.close, color: Colors.white),
//               onPressed: () {
//                 setState(() {
//                   searchKeyword = null;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     width: 170,
//                     margin: EdgeInsets.symmetric(
//                         vertical: 8), // إضافة مسافة بين العناصر
//                     decoration: BoxDecoration(
//                       color: KSf2,
//                       borderRadius:
//                           BorderRadius.circular(20), // جعل الحواف بيضاوية
//                     ),
//                     child: CustomDropdown<String>(
//                       items: [
//                         'All', // إضافة خيار "All"
//                         'Irbid',
//                         'Ajloun',
//                         'Jerash',
//                         'Mafraq',
//                         'Balqa',
//                         'Amman',
//                         'Zarqa',
//                         'Madaba',
//                         'Karak',
//                         'Tafilah',
//                         'Ma\'an',
//                         'Aqaba'
//                       ], // القيم المحددة مسبقًا
//                       hintText: 'All',
//                       labelText: 'City',
//                       initialValue: selectedCity,
//                       onChanged: (String? city) {
//                         setState(() {
//                           selectedCity = city == 'All'
//                               ? null
//                               : city; // تعيين القيمة إلى null إذا تم اختيار "All"
//                         });
//                         print(city);
//                       },
//                       dropdownMenuBackgroundColor: KSurface,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(
//                       vertical: 8), // إضافة مسافة بين العناصر
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius:
//                         BorderRadius.circular(20), // جعل الحواف بيضاوية
//                   ),
//                   child: CustomDropdown<String>(
//                     items: [
//                       'All', // إضافة خيار "All"
//                       'Irbid',
//                       'Ajloun',
//                       'Jerash',
//                       'Mafraq',
//                       'Balqa',
//                       'Amman',
//                       'Zarqa',
//                       'Madaba',
//                       'Karak',
//                       'Tafilah',
//                       'Ma\'an',
//                       'Aqaba'
//                     ], // القيم المحددة مسبقًا
//                     hintText: ' All',
//                     labelText: 'Rating',
//                     initialValue: selectedCity,
//                     onChanged: (String? city) {
//                       setState(() {
//                         selectedCity = city == 'All'
//                             ? null
//                             : city; // تعيين القيمة إلى null إذا تم اختيار "All"
//                       });
//                       print(city);
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('tradepersons')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No data available'),
//                   );
//                 }
//                 final users = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     final userDocument = users[index];

//                     // التحقق من تحديد الكل أو المدينة المحددة
//                     if ((selectedCity == null ||
//                             userDocument['City'] == selectedCity) &&
//                         (searchKeyword == null ||
//                             userDocument['FullName']
//                                 .toString()
//                                 .toLowerCase()
//                                 .contains(searchKeyword!.toLowerCase()))) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: Column(
//                           children: [
//                             Buildlistitem(userDocument: userDocument),
//                             if (index < users.length - 1) SizedBox(height: 8),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return SizedBox();
//                     }
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

// import 'package:fixit/screens/tradeperson_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/constants.dart';
// import '../widgets/buildlistitem.dart';
// import '../widgets/custom_drop_down.dart';

// class TradepersonListScreen extends StatefulWidget {
//   static String id = 'TradepersonListScreen';

//   @override
//   State<TradepersonListScreen> createState() => _TradepersonListScreenState();
// }

// class _TradepersonListScreenState extends State<TradepersonListScreen> {
//   String? selectedCity;
//   String? searchKeyword;

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     final String category = args['category'];

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: KSecondary,
//         title: Text(
//           'Tradepersons List',
//           style: TextStyle(fontFamily: Kword),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 25, right: 25, bottom: 6, top: 12),
//             child: TextField(
//               cursorColor: kPrimaryColor,
//               cursorHeight: 20,
//               style: TextStyle(color: Colors.white),
//               onChanged: (value) {
//                 setState(() {
//                   searchKeyword = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 hintText: 'Search by Name?',
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Playfair Display',
//                 ),
//                 filled: true,
//                 fillColor: KSf2,
//                 prefixIcon: Icon(Icons.search, color: Colors.white),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.close, color: Colors.white),
//                   onPressed: () {
//                     setState(() {
//                       searchKeyword = null;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<String>(
//                     items: [
//                       'All',
//                       'Irbid',
//                       'Ajloun',
//                       'Jerash',
//                       'Mafraq',
//                       'Balqa',
//                       'Amman',
//                       'Zarqa',
//                       'Madaba',
//                       'Karak',
//                       'Tafilah',
//                       'Ma\'an',
//                       'Aqaba'
//                     ],
//                     hintText: 'All',
//                     labelText: 'City',
//                     initialValue: selectedCity,
//                     onChanged: (String? city) {
//                       setState(() {
//                         selectedCity = city == 'All' ? null : city;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<String>(
//                     items: [
//                       'All',
//                       'Irbid',
//                       'Ajloun',
//                       'Jerash',
//                       'Mafraq',
//                       'Balqa',
//                       'Amman',
//                       'Zarqa',
//                       'Madaba',
//                       'Karak',
//                       'Tafilah',
//                       'Ma\'an',
//                       'Aqaba'
//                     ],
//                     hintText: 'All',
//                     labelText: 'Rating',
//                     initialValue: selectedCity,
//                     onChanged: (String? city) {
//                       setState(() {
//                         selectedCity = city == 'All' ? null : city;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('tradepersons')
//                   .where('Category', isEqualTo: category)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No data available'),
//                   );
//                 }
//                 final users = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     final userDocument = users[index];
//                     if ((selectedCity == null ||
//                             userDocument['City'] == selectedCity) &&
//                         (searchKeyword == null ||
//                             userDocument['FullName']
//                                 .toString()
//                                 .toLowerCase()
//                                 .contains(searchKeyword!.toLowerCase()))) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: GestureDetector(
//                           onTap: () {
//                             // Navigate to TradePersonDetailsScreen when a trade person is tapped
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => TradepersonDetailsScreen(
//                                   fullName: userDocument['FullName'],
//                                   city: userDocument['City'],
//                                   birthDate: userDocument['BirthOfDate'],
//                                   status: userDocument['Status'],
//                                   email: userDocument['Email'],
//                                   description: userDocument['Description'],
//                                   category: userDocument['Category'],
//                                   adress: userDocument['Address'],
//                                   imageUrl: userDocument[
//                                       'ImageLink'], // Pass imageUrl
//                                   phoneNumber: userDocument['PhoneNumber'],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Column(
//                             children: [
//                               Buildlistitem(userDocument: userDocument),
//                               if (index < users.length - 1) SizedBox(height: 8),
//                             ],
//                           ),
//                         ),
//                       );
//                     } else {
//                       return SizedBox();
//                     }
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
// import 'package:fixit/screens/tradeperson_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/constants.dart';
// import '../widgets/buildlistitem.dart';
// import '../widgets/custom_drop_down.dart';

// class TradepersonListScreen extends StatefulWidget {
//   static String id = 'TradepersonListScreen';

//   @override
//   State<TradepersonListScreen> createState() => _TradepersonListScreenState();
// }

// class _TradepersonListScreenState extends State<TradepersonListScreen> {
//   String? selectedCity;
//   String? searchKeyword;

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     final String category = args['category'];

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: KSecondary,
//         title: Text(
//           'Tradepersons List',
//           style: TextStyle(fontFamily: Kword),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 25, right: 25, bottom: 6, top: 12),
//             child: TextField(
//               cursorColor: kPrimaryColor,
//               cursorHeight: 20,
//               style: TextStyle(color: Colors.white),
//               onChanged: (value) {
//                 setState(() {
//                   searchKeyword = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 hintText: 'Search by Name?',
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Playfair Display',
//                 ),
//                 filled: true,
//                 fillColor: KSf2,
//                 prefixIcon: Icon(Icons.search, color: Colors.white),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.close, color: Colors.white),
//                   onPressed: () {
//                     setState(() {
//                       searchKeyword = null;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<String>(
//                     items: [
//                       'All',
//                       'Irbid',
//                       'Ajloun',
//                       'Jerash',
//                       'Mafraq',
//                       'Balqa',
//                       'Amman',
//                       'Zarqa',
//                       'Madaba',
//                       'Karak',
//                       'Tafilah',
//                       'Ma\'an',
//                       'Aqaba'
//                     ],
//                     hintText: 'All',
//                     labelText: 'City',
//                     initialValue: selectedCity,
//                     onChanged: (String? city) {
//                       setState(() {
//                         selectedCity = city == 'All' ? null : city;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<String>(
//                     items: [
//                       'All',
//                       'Irbid',
//                       'Ajloun',
//                       'Jerash',
//                       'Mafraq',
//                       'Balqa',
//                       'Amman',
//                       'Zarqa',
//                       'Madaba',
//                       'Karak',
//                       'Tafilah',
//                       'Ma\'an',
//                       'Aqaba'
//                     ],
//                     hintText: 'All',
//                     labelText: 'Rating',
//                     initialValue: selectedCity,
//                     onChanged: (String? city) {
//                       setState(() {
//                         selectedCity = city == 'All' ? null : city;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('tradepersons')
//                   .where('Category', isEqualTo: category)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No data available'),
//                   );
//                 }
//                 final users = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     final userDocument = users[index];
//                     if ((selectedCity == null ||
//                             userDocument['City'] == selectedCity) &&
//                         (searchKeyword == null ||
//                             userDocument['FullName']
//                                 .toString()
//                                 .toLowerCase()
//                                 .contains(searchKeyword!.toLowerCase()))) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: GestureDetector(
//                           onTap: () {
//                             // Navigate to TradePersonDetailsScreen when a trade person is tapped
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => TradepersonDetailsScreen(
//                                   email: userDocument['Email'],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Column(
//                             children: [
//                               Buildlistitem(userDocument: userDocument),
//                               if (index < users.length - 1) SizedBox(height: 8),
//                             ],
//                           ),
//                         ),
//                       );
//                     } else {
//                       return SizedBox();
//                     }
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
// import 'package:fixit/screens/tradeperson_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/constants.dart';
// import '../widgets/buildlistitem.dart';
// import '../widgets/custom_drop_down.dart';

// class TradepersonListScreen extends StatefulWidget {
//   static String id = 'TradepersonListScreen';

//   @override
//   State<TradepersonListScreen> createState() => _TradepersonListScreenState();
// }

// class _TradepersonListScreenState extends State<TradepersonListScreen> {
//   String? selectedCity;
//   int? selectedRating;
//   String? searchKeyword;

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     final String category = args['category'];

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: KSecondary,
//         title: Text(
//           'Tradepersons List',
//           style: TextStyle(fontFamily: Kword),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 25, right: 25, bottom: 6, top: 12),
//             child: TextField(
//               cursorColor: kPrimaryColor,
//               cursorHeight: 20,
//               style: TextStyle(color: Colors.white),
//               onChanged: (value) {
//                 setState(() {
//                   searchKeyword = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 hintText: 'Search by Name?',
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Playfair Display',
//                 ),
//                 filled: true,
//                 fillColor: KSf2,
//                 prefixIcon: Icon(Icons.search, color: Colors.white),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.close, color: Colors.white),
//                   onPressed: () {
//                     setState(() {
//                       searchKeyword = null;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<String>(
//                     items: [
//                       'All',
//                       'Irbid',
//                       'Ajloun',
//                       'Jerash',
//                       'Mafraq',
//                       'Balqa',
//                       'Amman',
//                       'Zarqa',
//                       'Madaba',
//                       'Karak',
//                       'Tafilah',
//                       'Ma\'an',
//                       'Aqaba'
//                     ],
//                     hintText: 'All',
//                     labelText: 'City',
//                     initialValue: selectedCity,
//                     onChanged: (String? city) {
//                       setState(() {
//                         selectedCity = city == 'All' ? null : city;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<dynamic>(
//                     items: ['All', 1, 2, 3, 4, 5],
//                     hintText: 'All',
//                     labelText: 'Rating',
//                     initialValue: selectedRating,
//                     onChanged: (dynamic? rating) {
//                       setState(() {
//                         selectedRating = rating == 'All' ? null : rating;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('tradepersons')
//                   .where('Category', isEqualTo: category)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No data available'),
//                   );
//                 }
//                 final users = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     final userDocument = users[index];
//                     final averageRating = userDocument['AverageRating'] ?? 0;
//                     if ((selectedCity == null ||
//                             userDocument['City'] == selectedCity) &&
//                         (selectedRating == null ||
//                             (averageRating >= selectedRating! &&
//                                 averageRating < selectedRating! + 1)) &&
//                         (searchKeyword == null ||
//                             userDocument['FullName']
//                                 .toString()
//                                 .toLowerCase()
//                                 .contains(searchKeyword!.toLowerCase()))) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => TradepersonDetailsScreen(
//                                   email: userDocument['Email'],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Column(
//                             children: [
//                               Buildlistitem(userDocument: userDocument),
//                               if (index < users.length - 1) SizedBox(height: 8),
//                             ],
//                           ),
//                         ),
//                       );
//                     } else {
//                       return SizedBox();
//                     }
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
// import 'package:fixit/screens/tradeperson_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/constants.dart';
// import '../widgets/buildlistitem.dart';
// import '../widgets/custom_drop_down.dart';

// class TradepersonListScreen extends StatefulWidget {
//   static String id = 'TradepersonListScreen';

//   @override
//   State<TradepersonListScreen> createState() => _TradepersonListScreenState();
// }

// class _TradepersonListScreenState extends State<TradepersonListScreen> {
//   String? selectedCity;
//   int? selectedRating;
//   String? searchKeyword;

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     final String category = args['category'];

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: KSecondary,
//         title: Text(
//           'Tradepersons List',
//           style: TextStyle(fontFamily: Kword),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 25, right: 25, bottom: 6, top: 12),
//             child: TextField(
//               cursorColor: kPrimaryColor,
//               cursorHeight: 20,
//               style: TextStyle(color: Colors.white),
//               onChanged: (value) {
//                 setState(() {
//                   searchKeyword = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 hintText: 'Search by Name?',
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Playfair Display',
//                 ),
//                 filled: true,
//                 fillColor: KSf2,
//                 prefixIcon: Icon(Icons.search, color: Colors.white),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.close, color: Colors.white),
//                   onPressed: () {
//                     setState(() {
//                       searchKeyword = null;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<String>(
//                     items: [
//                       'All',
//                       'Irbid',
//                       'Ajloun',
//                       'Jerash',
//                       'Mafraq',
//                       'Balqa',
//                       'Amman',
//                       'Zarqa',
//                       'Madaba',
//                       'Karak',
//                       'Tafilah',
//                       'Ma\'an',
//                       'Aqaba'
//                     ],
//                     hintText: 'All',
//                     labelText: 'City',
//                     initialValue: selectedCity,
//                     onChanged: (String? city) {
//                       setState(() {
//                         selectedCity = city == 'All' ? null : city;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   margin: EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     color: KSf2,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomDropdown<dynamic>(
//                     items: ['All', 1, 2, 3, 4, 5],
//                     hintText: 'All',
//                     labelText: 'Rating',
//                     initialValue: selectedRating,
//                     onChanged: (dynamic? rating) {
//                       setState(() {
//                         selectedRating = rating == 'All' ? null : rating;
//                       });
//                     },
//                     dropdownMenuBackgroundColor: KSurface,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('tradepersons')
//                   .where('Category', isEqualTo: category)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No data available'),
//                   );
//                 }

//                 final users = snapshot.data!.docs;

//                 // Sort users by isSubscribed status
//                 final sortedUsers = users
//                     .where((user) => user['isSubscribed'] == 'yes')
//                     .toList()
//                   ..addAll(users
//                       .where((user) => user['isSubscribed'] == 'no')
//                       .toList());

//                 return ListView.builder(
//                   itemCount: sortedUsers.length,
//                   itemBuilder: (context, index) {
//                     final userDocument = sortedUsers[index];
//                     final averageRating = userDocument['AverageRating'] ?? 0;
//                     if ((selectedCity == null ||
//                             userDocument['City'] == selectedCity) &&
//                         (selectedRating == null ||
//                             (averageRating >= selectedRating! &&
//                                 averageRating < selectedRating! + 1)) &&
//                         (searchKeyword == null ||
//                             userDocument['FullName']
//                                 .toString()
//                                 .toLowerCase()
//                                 .contains(searchKeyword!.toLowerCase()))) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => TradepersonDetailsScreen(
//                                   email: userDocument['Email'],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Column(
//                             children: [
//                               Buildlistitem(userDocument: userDocument),
//                               if (index < sortedUsers.length - 1)
//                                 SizedBox(height: 8),
//                             ],
//                           ),
//                         ),
//                       );
//                     } else {
//                       return SizedBox();
//                     }
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
import 'package:fixit/screens/tradeperson_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import '../widgets/buildlistitem.dart';
import '../widgets/custom_drop_down.dart';

class TradepersonListScreen extends StatefulWidget {
  static String id = 'TradepersonListScreen';

  @override
  State<TradepersonListScreen> createState() => _TradepersonListScreenState();
}

class _TradepersonListScreenState extends State<TradepersonListScreen> {
  String? selectedCity;
  int? selectedRating;
  String? searchKeyword;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String category = args['category'];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: KSecondary,
        title: Text(
          'Tradepersons List',
          style: TextStyle(fontFamily: Kword),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 6, top: 12),
            child: TextField(
              cursorColor: kPrimaryColor,
              cursorHeight: 20,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Search by Name?',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Playfair Display',
                ),
                filled: true,
                fillColor: KSf2,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      searchKeyword = null;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 170,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: KSf2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomDropdown<String>(
                    items: [
                      'All',
                      'Irbid',
                      'Ajloun',
                      'Jerash',
                      'Mafraq',
                      'Balqa',
                      'Amman',
                      'Zarqa',
                      'Madaba',
                      'Karak',
                      'Tafilah',
                      'Ma\'an',
                      'Aqaba'
                    ],
                    hintText: 'All',
                    labelText: 'City',
                    initialValue: selectedCity,
                    onChanged: (String? city) {
                      setState(() {
                        selectedCity = city == 'All' ? null : city;
                      });
                    },
                    dropdownMenuBackgroundColor: KSurface,
                  ),
                ),
                Container(
                  width: 170,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: KSf2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomDropdown<dynamic>(
                    items: ['All', 1, 2, 3, 4, 5],
                    hintText: 'All',
                    labelText: 'Rating',
                    initialValue: selectedRating,
                    onChanged: (dynamic? rating) {
                      setState(() {
                        selectedRating = rating == 'All' ? null : rating;
                      });
                    },
                    dropdownMenuBackgroundColor: KSurface,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tradepersons')
                  .where('Category', isEqualTo: category)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "There's no Tradeperson here yet",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final users = snapshot.data!.docs;

                // Sort users by isSubscribed status
                final sortedUsers = users
                    .where((user) => user['isSubscribed'] == 'yes')
                    .toList()
                  ..addAll(users
                      .where((user) => user['isSubscribed'] == 'no')
                      .toList());

                return ListView.builder(
                  itemCount: sortedUsers.length,
                  itemBuilder: (context, index) {
                    final userDocument = sortedUsers[index];
                    final averageRating = userDocument['AverageRating'] ?? 0;
                    if ((selectedCity == null ||
                            userDocument['City'] == selectedCity) &&
                        (selectedRating == null ||
                            (averageRating >= selectedRating! &&
                                averageRating < selectedRating! + 1)) &&
                        (searchKeyword == null ||
                            userDocument['FullName']
                                .toString()
                                .toLowerCase()
                                .contains(searchKeyword!.toLowerCase()))) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TradepersonDetailsScreen(
                                  email: userDocument['Email'],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Buildlistitem(userDocument: userDocument),
                              if (index < sortedUsers.length - 1)
                                SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
