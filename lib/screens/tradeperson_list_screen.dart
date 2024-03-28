import 'package:flutter/material.dart';

import '../widgets/buildlistitem.dart';

class TradepersonListScreen extends StatelessWidget {
  String selectedFilter = 'All';
  static String id = 'TradepersonListScreen';

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
              hintStyle: TextStyle(color: Colors.white),
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
              child: DropdownButton<String>(
                value: selectedFilter,
                onChanged: (newValue) {
                  selectedFilter = newValue!;
                },
                items: <String>[
                  'All',
                  'Irbid',
                  'Amman',
                  'Al-Zarqa',
                  'Aqaba',
                  'Jerash',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  // Replace with your actual list item widget
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Buildlistitem(),
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
