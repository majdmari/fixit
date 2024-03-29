import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/buildlistitem.dart';

class TradepersonListScreen extends StatefulWidget {
  static String id = 'TradepersonListScreen';

  @override
  State<TradepersonListScreen> createState() => _TradepersonListScreenState();
}

class _TradepersonListScreenState extends State<TradepersonListScreen> {
  String selectedCity = '0';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0Xff000000),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: TextField(
            cursorColor: Color(0XffB73B67),
            cursorHeight: 20,
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
              fillColor: Color(0Xff2B2831),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Color(0Xff2B2831),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  List<DropdownMenuItem<String>> usersItems = [];
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    final users = snapshot.data!.docs.reversed.toList();
                    usersItems.add(
                      DropdownMenuItem(
                        value: '0',
                        child: Text('Select city'),
                      ),
                    );
                    for (var user in users) {
                      usersItems.add(
                        DropdownMenuItem(
                          value: user.id,
                          child: Text(user['City']),
                        ),
                      );
                    }
                    return DropdownButton<String>(
                      items: usersItems,
                      onChanged: (String? usersValue) {
                        setState(() {
                          selectedCity = usersValue!;
                        });
                        print(usersValue);
                      },
                      value: selectedCity,
                      isExpanded: false,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Assuming _allResults is defined somewhere
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Buildlistitem(), // Pass _allResults to this widget
                        if (index < 9) SizedBox(height: 8),
                      ],
                    ),
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
