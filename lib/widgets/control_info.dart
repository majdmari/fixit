import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlInfo extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;
  final VoidCallback onDeletePressed;

  const ControlInfo({
    Key? key,
    required this.userDocument,
    required this.onDeletePressed,
  }) : super(key: key);

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
                    userDocument['ImageLink'] ?? '', // تحقق من وجود الصورة
                    width: 70, // تحديد عرض الصورة بشكل ثابت
                    height: 70, // تحديد ارتفاع الصورة بشكل ثابت
                    fit: BoxFit.cover, // تحديد كيفية تناسب الصورة داخل الحاوية
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
                  onPressed: onDeletePressed,
                  elevation: 2.0,
                  fillColor: KSf2,
                  child: Icon(
                    Icons.delete_forever,
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
