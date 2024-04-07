// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 70,
//             ),
//             ElevatedButton(onPressed: retriveSub, child: Text('ret')),
//           ],
//         ),
//       ),
//     );
//   }

//   void retriveSub() {
//     FirebaseFirestore.instance.collection('tradepersons').get().then((value) {
//       value.docs.forEach((result) {
//         FirebaseFirestore.instance
//             .collection('tradepersons')
//             .doc(result.id)
//             .collection('info')
//             .get()
//             .then((subCol) {
//           subCol.docs.forEach((element) {
//             print(element.data());
//           });
//         });
//       });
//     });
//   }
// }


//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: 170,
//                       margin: EdgeInsets.symmetric(
//                           vertical: 8), // إضافة مسافة بين العناصر
//                       decoration: BoxDecoration(
//                         color: KSf2,
//                         borderRadius:
//                             BorderRadius.circular(20), // جعل الحواف بيضاوية
//                       ),
//                       child: StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('tradepersons')
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return CircularProgressIndicator();
//                           } else {
//                             final users = snapshot.data!.docs;
//                             for (var user in users) {
//                               cities.add(user['City']);
//                             }

//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8),
//                               child: CustomDropdown<String>(
//                                 items: cities.toList(),
//                                 hintText: 'All',
//                                 labelText: 'City',
//                                 initialValue: selectedCity,
//                                 onChanged: (String? city) {
//                                   setState(() {
//                                     selectedCity = city;
//                                   });
//                                   print(city);
//                                 },
//                                 dropdownMenuBackgroundColor: KSurface,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ),


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
//   String? selectedCity;
//   String? searchKeyword;
//   Set<String> cities = {};

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Color(0Xff000000),
//         appBar: AppBar(
//           backgroundColor: Colors.orange,
//           title: TextField(
//             cursorColor: Color(0XffB73B67),
//             cursorHeight: 20,
//             style: TextStyle(color: Colors.white),
//             onChanged: (value) {
//               setState(() {
//                 searchKeyword = value;
//               });
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(42),
//               ),
//               hintText: 'Search by Name?',
//               hintStyle: TextStyle(
//                 color: Colors.white,
//                 fontFamily: 'Playfair Display',
//               ),
//               filled: true,
//               fillColor: KSf2,
//               prefixIcon: Icon(Icons.search, color: Colors.white),
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.close, color: Colors.white),
//                 onPressed: () {
//                   setState(() {
//                     searchKeyword = null;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: 170,
//                       margin: EdgeInsets.symmetric(vertical: 8),
//                       decoration: BoxDecoration(
//                         color: KSf2,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('tradepersons')
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return CircularProgressIndicator();
//                           } else {
//                             final users = snapshot.data!.docs;
//                             for (var user in users) {
//                               cities.add(user['City']);
//                             }

//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8),
//                               child: CustomDropdown<String>(
//                                 items: cities.toList(),
//                                 hintText: 'All',
//                                 labelText: 'City',
//                                 initialValue: selectedCity,
//                                 onChanged: (String? city) {
//                                   setState(() {
//                                     selectedCity = city;
//                                   });
//                                   print(city);
//                                 },
//                                 dropdownMenuBackgroundColor: KSurface,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 170,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                       color: KSf2,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('tradepersons')
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return CircularProgressIndicator();
//                         } else {
//                           final users = snapshot.data!.docs;
//                           for (var user in users) {
//                             cities.add(user['City']);
//                           }

//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: CustomDropdown<String>(
//                               items: cities.toList(),
//                               hintText: 'All',
//                               labelText: 'Rating',
//                               initialValue: selectedCity,
//                               onChanged: (String? city) {
//                                 setState(() {
//                                   selectedCity = city;
//                                 });
//                                 print(city);
//                               },
//                               dropdownMenuBackgroundColor: KSurface,
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
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

//                       // Check if city and search keyword match
//                       if ((selectedCity == null ||
//                               userDocument['City'] == selectedCity) &&
//                           (searchKeyword == null ||
//                               userDocument['FullName']
//                                   .toString()
//                                   .toLowerCase()
//                                   .contains(searchKeyword!.toLowerCase()))) {
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
//                       } else {
//                         return SizedBox();
//                       }
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

//  CustomButton(
//                       text: 'Continue',
//                       onTap: () async {
//                         if (formKey.currentState!.validate()) {
//                           if (registerInfo.password !=
//                               registerInfo.confirmPassword) {
//                             showSnackBar(context, 'Passwords do not match');
//                             return;
//                           }
//                           isLoading = true;
//                           setState(() {});
//                           try {
//                             await registerUser();
//                             late CollectionReference
//                                 collectionReference; // Declare as late
//                             if (registerInfo.selectedOption == "User") {
//                               collectionReference = FirebaseFirestore.instance
//                                   .collection('users');
//                             } else if (registerInfo.selectedOption ==
//                                 "Tradeperson") {
//                               collectionReference = FirebaseFirestore.instance
//                                   .collection('tradepersons');
//                               // .doc(registerViewModel.emailController.text)
//                               // .collection('information');
//                             }
//                             await collectionReference
//                                 .doc(registerViewModel.emailController.text)
//                                 .set({
//                               'Email': registerInfo.email,
//                               'Password': registerInfo.password,
//                               'Gender': registerInfo.selectedGender,
//                               'Type': registerInfo.selectedOption,
//                               'Status': 'Available '
//                             });
//                             if (registerInfo.selectedOption == "Tradeperson") {
//                               await FirebaseFirestore.instance
//                                   .collection('tradepersons')
//                                   .doc(registerViewModel.emailController.text)
//                                   .collection('comment')
//                                   .doc()
//                                   .set({});
//                             }
//                             showSnackBar(context, 'Success');
//                             if (registerInfo.selectedOption == "User") {
//                               Navigator.pushNamed(
//                                   context, UserRegisterScreen.id);
//                             } else if (registerInfo.selectedOption ==
//                                 "Tradeperson") {
//                               Navigator.pushNamed(
//                                   context, TradepersonRegisterScreen.id);
//                             }
//                           } on FirebaseAuthException catch (ex) {
//                             if (ex.code == 'weak-password') {
//                               showSnackBar(context, 'Weak password');
//                             } else if (ex.code == 'email-already-in-use') {
//                               showSnackBar(context,
//                                   'The account already exists for that email.');
//                             }
//                           } catch (ex) {
//                             showSnackBar(context, 'There was an error');
//                           }
//                           isLoading = false;
//                           setState(() {});
//                         }
//                       },
//                     ),
