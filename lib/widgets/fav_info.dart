// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FavInfo extends StatelessWidget {
//   final QueryDocumentSnapshot userDocument;
//   final VoidCallback onRemove;

//   const FavInfo({
//     Key? key,
//     required this.userDocument,
//     required this.onRemove,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: KSf2, // Set the background color to KSf2
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Image.network(
//                 userDocument['ImageLink'] ?? '',
//                 width: 70,
//                 height: 70,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     userDocument['FullName'] ?? 'Unknown',
//                     style: TextStyle(
//                       color: Colors.white, // Set text color to white
//                       fontSize: 20,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: Colors.white, // Set icon color to white
//                         size: 18,
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         '4.7',
//                         style: TextStyle(
//                           color: Colors.white, // Set text color to white
//                         ),
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         userDocument['City'] ?? 'Unknown',
//                         style: TextStyle(
//                           color: Colors.white, // Set text color to white
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Spacer(),
//             RawMaterialButton(
//               onPressed: onRemove,
//               elevation: 2.0,
//               fillColor: KSf2,
//               child: Icon(
//                 Icons.favorite,
//                 color: Colors.red,
//                 size: 35.0,
//               ),
//               padding: EdgeInsets.all(15.0),
//               shape: CircleBorder(),
//             ),
//             RawMaterialButton(
//               onPressed: () {},
//               elevation: 2.0,
//               fillColor: KSf2,
//               child: Icon(
//                 Icons.phone,
//                 color: kPrimaryColor,
//                 size: 35.0,
//               ),
//               padding: EdgeInsets.all(15.0),
//               shape: CircleBorder(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class FavInfo extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;
  final VoidCallback onRemove;
  final String? imageUrl;
  final String? city;
  final String? fullName;
  final String? phoneNumber;
  final double? averageRating;

  const FavInfo(
      {Key? key,
      required this.userDocument,
      required this.onRemove,
      this.city,
      this.fullName,
      this.phoneNumber,
      this.averageRating,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KSf2, // Set the background color to KSf2
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl ?? '',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fullName ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white, // Set icon color to white
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        averageRating!.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        city ?? 'Unknown',
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            RawMaterialButton(
              onPressed: onRemove,
              elevation: 2.0,
              fillColor: KSf2,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 35.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
            RawMaterialButton(
              onPressed: () {
                FlutterPhoneDirectCaller.callNumber(phoneNumber.toString());
              },
              elevation: 2.0,
              fillColor: KSf2,
              child: Icon(
                Icons.phone,
                color: kPrimaryColor,
                size: 35.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
