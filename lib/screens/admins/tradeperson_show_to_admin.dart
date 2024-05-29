import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/review_list_screen.dart';
import 'package:fixit/screens/user_writeReview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class TradepersonShowToAdminScreen extends StatefulWidget {
  static String id = 'TradepersonShowToAdminScreen';

  final String email;

  TradepersonShowToAdminScreen({
    required this.email,
  });

  @override
  State<TradepersonShowToAdminScreen> createState() =>
      _TradepersonShowToAdminScreenState();
}

class _TradepersonShowToAdminScreenState
    extends State<TradepersonShowToAdminScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontFamily: Kword),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tradepersons')
              .doc(widget.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var tradePersonData = snapshot.data!.data() as Map<String, dynamic>;
            double totalRating =
                (tradePersonData['TotalRating'] ?? 0).toDouble();
            int reviewsNumber = tradePersonData['ReviewsNumber'] ?? 0;
            double averageRating =
                reviewsNumber != 0 ? totalRating / reviewsNumber : 0;
            // Update AverageRating in tradepersons collection
            updateAverageRating(averageRating);

            return ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(tradePersonData['ImageLink']),
                            radius: 68,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      tradePersonData['FullName'],
                      style: TextStyle(
                          color: Colors.white, fontSize: 25, fontFamily: Kword),
                    ),
                    Text(
                      tradePersonData['Category'],
                      style: TextStyle(
                          color: Colors.grey, fontSize: 20, fontFamily: Kword),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Email:  ${widget.email} ",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "City : ${tradePersonData['City']}",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Address : ${tradePersonData['Address']}",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "BirthDay : ${tradePersonData['BirthOfDate']}",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Status : ${tradePersonData['Status']}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: Kword),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                      height: 10,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tradePersonData['Description'],
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: Kword),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                      height: 10,
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            Text(
                              averageRating.toStringAsFixed(2) + ' ● ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            GestureDetector(
                              child: Text(
                                reviewsNumber.toString() + ' review',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewListScreen(
                                      email: widget.email,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.comment,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                      height: 10,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        IconButton(
                          onPressed: () {
                            FlutterPhoneDirectCaller.callNumber(
                                tradePersonData['PhoneNumber']);
                          },
                          icon: Icon(
                            Icons.call,
                            size: 60,
                            color: KSecondary,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void updateAverageRating(double averageRating) async {
    // Get a reference to the document in the 'tradepersons' collection
    DocumentReference tradePersonRef =
        FirebaseFirestore.instance.collection('tradepersons').doc(widget.email);

    // Update the document with the new averageRating
    await tradePersonRef.update({'AverageRating': averageRating});
  }
}
