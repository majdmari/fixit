import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import '../widgets/buildlistitem.dart';

class TradepersonListScreen extends StatefulWidget {
  static String id = 'TradepersonListScreen';

  @override
  State<TradepersonListScreen> createState() => _TradepersonListScreenState();
}

class _TradepersonListScreenState extends State<TradepersonListScreen> {
  String? selectedCity; // قيمة افتراضية ممكنة هي null
  String? searchKeyword; // الكلمة المراد البحث عنها
  Set<String> cities = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: TextField(
            cursorColor: Color(0XffB73B67),
            cursorHeight: 20,
            style: TextStyle(color: Colors.white), // تعيين لون النص إلى الأبيض
            onChanged: (value) {
              setState(() {
                searchKeyword = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(42),
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 170,
                      margin: EdgeInsets.symmetric(
                          vertical: 8), // إضافة مسافة بين العناصر
                      decoration: BoxDecoration(
                        color: KSf2,
                        borderRadius:
                            BorderRadius.circular(20), // جعل الحواف بيضاوية
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('tradepersons')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            final users = snapshot.data!.docs;
                            for (var user in users) {
                              cities.add(user['City']);
                            }

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CustomDropdown<String>(
                                items: cities.toList(),
                                hintText: 'All',
                                labelText: 'City',
                                initialValue: selectedCity,
                                onChanged: (String? city) {
                                  setState(() {
                                    selectedCity = city;
                                  });
                                  print(city);
                                },
                                dropdownMenuBackgroundColor: KSurface,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 170,
                    margin: EdgeInsets.symmetric(
                        vertical: 8), // إضافة مسافة بين العناصر
                    decoration: BoxDecoration(
                      color: KSf2,
                      borderRadius:
                          BorderRadius.circular(20), // جعل الحواف بيضاوية
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('tradepersons')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          final users = snapshot.data!.docs;
                          for (var user in users) {
                            cities.add(user['City']);
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CustomDropdown<String>(
                              items: cities.toList(),
                              hintText: 'All',
                              labelText: 'Rating',
                              initialValue: selectedCity,
                              onChanged: (String? city) {
                                setState(() {
                                  selectedCity = city;
                                });
                                print(city);
                              },
                              dropdownMenuBackgroundColor: KSurface,
                            ),
                          );
                        }
                      },
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
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No data available'),
                    );
                  }
                  final users = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final userDocument = users[index];

                      // التحقق من تحديد الكل أو المدينة المحددة
                      if ((selectedCity == null ||
                              userDocument['City'] == selectedCity) &&
                          (searchKeyword == null ||
                              userDocument['FullName']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchKeyword!.toLowerCase()))) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Buildlistitem(userDocument: userDocument),
                              if (index < users.length - 1) SizedBox(height: 8),
                            ],
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
      ),
    );
  }
}
