// import 'package:fixit/screens/tradeperson_details_screen.dart';
// import 'package:fixit/widgets/build_cotrol_list.dart';
// import 'package:fixit/widgets/buildlistitem.dart';
// import 'package:fixit/widgets/custom_drop_down.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fixit/constants.dart';

// class AdminControlScreen extends StatefulWidget {
//   static String id = 'AdminControlScreen';

//   @override
//   State<AdminControlScreen> createState() => _AdminControlScreenState();
// }

// class _AdminControlScreenState extends State<AdminControlScreen> {
//   String? selectedCity;
//   String? selectedCategory;

//   String? searchKeyword;

//   @override
//   Widget build(BuildContext context) {
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
//                     items: ['All', 'Electrician', 'Plumber', 'Carpenter'],
//                     hintText: 'All',
//                     labelText: 'Category',
//                     initialValue: selectedCategory,
//                     onChanged: (String? category) {
//                       setState(() {
//                         selectedCategory = category == 'All' ? null : category;
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
//                               BuildCotrolList(
//                                 userDocument: userDocument,
//                                 onDeletePressed: () {
//                                   deleteUser(userDocument[
//                                       'Email']); // Assuming the document ID is used as the user ID
//                                 },
//                               ),
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

//   Future<void> deleteUser(String userId) async {
//     // Delete from Firestore
//     await FirebaseFirestore.instance
//         .collection('tradepersons')
//         .doc(userId)
//         .delete();
//   }
// }
import 'package:fixit/screens/tradeperson_details_screen.dart';
import 'package:fixit/widgets/build_cotrol_list.dart';
import 'package:fixit/widgets/buildlistitem.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';

class AdminControlScreen extends StatefulWidget {
  static String id = 'AdminControlScreen';

  @override
  State<AdminControlScreen> createState() => _AdminControlScreenState();
}

class _AdminControlScreenState extends State<AdminControlScreen> {
  String? selectedCity;
  String? selectedCategory;
  String? searchKeyword;

  @override
  Widget build(BuildContext context) {
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
                  child: CustomDropdown<String>(
                    items: ['All', 'Electrician', 'Plumber', 'Carpenter'],
                    hintText: 'All',
                    labelText: 'Category',
                    initialValue: selectedCategory,
                    onChanged: (String? category) {
                      setState(() {
                        selectedCategory = category == 'All' ? null : category;
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
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No data available'),
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
                    if ((selectedCity == null ||
                            userDocument['City'] == selectedCity) &&
                        (selectedCategory == null ||
                            userDocument['Category'] == selectedCategory) &&
                        (searchKeyword == null ||
                            userDocument['FullName']
                                .toString()
                                .toLowerCase()
                                .contains(searchKeyword!.toLowerCase()))) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to TradePersonDetailsScreen when a trade person is tapped
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
                              BuildCotrolList(
                                userDocument: userDocument,
                                onDeletePressed: () {
                                  deleteUser(userDocument[
                                      'Email']); // Assuming the document ID is used as the user ID
                                },
                              ),
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

  Future<void> deleteUser(String userId) async {
    // Delete from Firestore
    await FirebaseFirestore.instance
        .collection('tradepersons')
        .doc(userId)
        .delete();
  }
}
