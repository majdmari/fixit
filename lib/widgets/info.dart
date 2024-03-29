import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No data available'),
          );
        }
        // عدد العناصر الموجودة في مجموعة البيانات
        int itemCount = snapshot.data!.docs.length;

        return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            return Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0Xff2B2831),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/images/tradeperson.jpg'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doc['FullName'] ?? 'Unknown',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Playfair Display',
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0XffFFFFFF),
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '4.7',
                            style: TextStyle(
                              color: Color(0XffFFFFFF),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            doc['City'] ?? 'Unknown',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Playfair Display',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color(0Xff2B2831),
                  child: Icon(
                    Icons.phone,
                    color: Color(0XffB73B67),
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                )
              ],
            );
          },
        );
      },
    );
  }
}


// class Info extends StatefulWidget {
//   const Info({Key? key}) : super(key: key);

//   @override
//   _InfoState createState() => _InfoState();
// }

// class _InfoState extends State<Info> {
//   List _allResults = [];
//   late StreamSubscription<QuerySnapshot> _subscription;

//   @override
//   void initState() {
//     super.initState();
//     _subscribeToData();
//   }

//   @override
//   void dispose() {
//     _subscription.cancel(); // Cancel the subscription to prevent memory leaks
//     super.dispose();
//   }

//   void _subscribeToData() {
//     _subscription = FirebaseFirestore.instance
//         .collection('Users')
//         .orderBy('FullName')
//         .snapshots()
//         .listen((snapshot) {
//       setState(() {
//         _allResults = snapshot.docs;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _allResults.length,
//       itemBuilder: (context, index) {
//         return Row(
//           children: [
//             Expanded(
//               child: Container(
//                 color: Color(0Xff2B2831),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.asset('assets/images/tradeperson.jpg')),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     _allResults[index]['FullName'] ?? 'Unknown',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontFamily: 'Playfair Display',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: Color(0XffFFFFFF),
//                         size: 18,
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         '4.7',
//                         style: TextStyle(
//                           color: Color(0XffFFFFFF),
//                         ),
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         _allResults[index]['City'] ?? 'Unknown',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontFamily: 'Playfair Display',
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Spacer(),
//             RawMaterialButton(
//               onPressed: () {},
//               elevation: 2.0,
//               fillColor: Color(0Xff2B2831),
//               child: Icon(
//                 Icons.phone,
//                 color: Color(0XffB73B67),
//                 size: 35.0,
//               ),
//               padding: EdgeInsets.all(15.0),
//               shape: CircleBorder(),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
