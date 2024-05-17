// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ReviewInfo extends StatelessWidget {
//   final QueryDocumentSnapshot userDocument;

//   const ReviewInfo({Key? key, required this.userDocument}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: KSf2,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       userDocument['content'] ?? 'Unknown',
//                       overflow: TextOverflow.visible,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontFamily: Kword,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
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
import 'package:intl/intl.dart';

class ReviewInfo extends StatefulWidget {
  final QueryDocumentSnapshot userDocument;

  const ReviewInfo({Key? key, required this.userDocument}) : super(key: key);

  @override
  _ReviewInfoState createState() => _ReviewInfoState();
}

class _ReviewInfoState extends State<ReviewInfo> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.userDocument['timestamp'] ?? Timestamp.now();
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat('dd-MM-yyyy ').format(date);

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/female.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Text(
                widget.userDocument['userName'] ?? 'Unknown User',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: Kword,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.star, color: KSecondary, size: 20),
              SizedBox(width: 5),
              Text(
                widget.userDocument['rating'].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(formattedDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
            ],
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              if (widget.userDocument['imageUrl'] != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Image.network(
                      widget.userDocument['imageUrl'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.userDocument['imageUrl'] != null)
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      widget.userDocument['imageUrl'] ?? '',
                      width: 100,
                      height: 100,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (widget.userDocument['content'] ?? 'Unknown').length >
                                100
                            ? isExpanded
                                ? widget.userDocument['content']
                                : (widget.userDocument['content'] ?? 'Unknown')
                                        .substring(0, 100) +
                                    '...'
                            : widget.userDocument['content'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: Kword,
                        ),
                      ),
                      if ((widget.userDocument['content'] ?? '').length > 100)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Text(
                            isExpanded ? 'Less' : 'Read more',
                            style: TextStyle(color: KSecondary),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
