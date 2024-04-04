import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Info extends StatelessWidget {
  final QueryDocumentSnapshot userDocument;

  const Info({Key? key, required this.userDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0Xff2B2831),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/tradeperson.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userDocument['FullName'] ?? 'Unknown',
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
                        userDocument['City'] ?? 'Unknown',
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
        ),
      ),
    );
  }
}
