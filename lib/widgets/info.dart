import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  List _allResults = [];

  @override
  void initState() {
    super.initState();
    getUserStream();
  }

  Future<void> getUserStream() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('FullName')
        .get();
    setState(() {
      _allResults = data.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _allResults.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              color: Color(0Xff2B2831),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/tradeperson.jpg'),
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
                    _allResults[index]['FullName'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Playfair Display',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                        _allResults[index]['City'],
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
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

//  class Info extends StatefulWidget {
//    Info({super.key});
//  List _allResults = [];
 
  
//   @override
//    void initState() {
//     getUserStream();
//     super.initState();
//   }
  
//   getUserStream() async {
//     var data = await FirebaseFirestore.instance
//         .collection('users')
//         .orderBy('FullName')
//         .get();
//     setState(() {
//       _allResults = data.docs;
//     });}
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           color: Color(0Xff2B2831),
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Image.asset('assets/images/tradeperson.jpg'),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 _allResults[index]['FullName'],
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontFamily: 'Playfair Display'),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     Icons.star,
//                     color: Color(0XffFFFFFF),
//                     size: 18,
//                   ),
//                   SizedBox(width: 5),
//                   Text(
//                     '4.7',
//                     style: TextStyle(
//                       color: Color(0XffFFFFFF),
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   Text(
//                     _allResults[index]['City'],
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontFamily: 'Playfair Display'),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         Spacer(),
//         RawMaterialButton(
//           onPressed: () {},
//           elevation: 2.0,
//           fillColor: Color(0Xff2B2831),
//           child: Icon(
//             Icons.phone,
//             color: Color(0XffB73B67),
//             size: 35.0,
//           ),
//           padding: EdgeInsets.all(15.0),
//           shape: CircleBorder(),
//         )
//       ],
//     );
//   }
// }

  
  
// }
