import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Info extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;

  const Info({Key? key, required this.userDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KSf2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Row(
                children: [
                  Text(
                    userDocument['FullName'] ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: Kword,
                    ),
                  ),
                  SizedBox(width: 5),
                  if (userDocument['isSubscribed'] == 'yes')
                    Icon(
                      Icons.star,
                      color: Colors.yellow, // Star color
                      size: 20,
                    ),
                ],
              ),
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    userDocument['ImageLink'] ?? '', // Ensure image exists
                    width: 70, // Fixed width
                    height: 70, // Fixed height
                    fit: BoxFit.cover, // Image fit
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            userDocument['AverageRating'].toStringAsFixed(2) ??
                                'Unknown',
                            style: TextStyle(
                              color: Color(0XffFFFFFF),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            userDocument['City'] ?? 'Unknown',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: Kword,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                RawMaterialButton(
                  onPressed: () {
                    FlutterPhoneDirectCaller.callNumber(
                        userDocument['PhoneNumber']);
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
