import 'package:fixit/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/widgets/fav_info.dart'; // Import the FavInfo widget file
import '../screens/tradeperson_details_screen.dart';

class FavoriteListScreen extends StatefulWidget {
  static String id = 'FavoriteListScreen';

  @override
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> favoriteListStream;
  late User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user!.email ?? "";
      favoriteListStream = FirebaseFirestore.instance
          .collection('favorites')
          .doc(userEmail)
          .collection('favoriteList')
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite List'),
      ),
      backgroundColor: KSurface,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: favoriteListStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> favoriteList =
                snapshot.data!.docs
                    .map((doc) =>
                        doc as QueryDocumentSnapshot<Map<String, dynamic>>)
                    .toList();

            return ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final tradePersonData = favoriteList[index].data()!;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to TradepersonDetailsScreen when a favorite trade person is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TradepersonDetailsScreen(
                            fullName: tradePersonData['FullName'],
                            city: tradePersonData['City'],
                            birthDate: tradePersonData['BirthOfDate'],
                            status: tradePersonData['Status'],
                            email: tradePersonData['Email'],
                            description: tradePersonData['Desc'],
                            category: tradePersonData['Category'],
                            imageUrl: tradePersonData['ImageLink'],
                          ),
                        ),
                      );
                    },
                    child: FavInfo(
                      userDocument: favoriteList[index],
                      onRemove: () {
                        // Remove the document from Firestore
                        String docId = favoriteList[index].id;
                        FirebaseFirestore.instance
                            .collection('favorites')
                            .doc(user!.email)
                            .collection('favoriteList')
                            .doc(docId)
                            .delete();
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
