// import 'package:flutter/material.dart';

// void main() {
//   runApp(Tradeperson_screen());
// }

// class Tradeperson_screen extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       backgroundColor: Color(0Xff000000),
//       body: ListView.builder(
//           itemCount: 10,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color(0Xff2B2831)),
//                     height: 100,
//                     child: Row(
//                       children: [
//                         Container(
//                             color: const Color(0Xff2B2831),
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Image.asset(
//                                       'assets/images/tradeperson.jpg')),
//                             )),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('Jenny Wilson',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                   )),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     color: Color(0XffFFFFFF),
//                                     size: 18,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     '4.7',
//                                     style: TextStyle(color: Color(0XffFFFFFF)),
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text('irbid',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18,
//                                       )),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         const Spacer(
//                           flex: 1,
//                         ),
//                         RawMaterialButton(
//                           onPressed: () {},
//                           elevation: 2.0,
//                           fillColor: Color(0Xff2B2831),
//                           child: Icon(
//                             Icons.phone,
//                             color: Color(0XffB73B67),
//                             size: 35.0,
//                           ),
//                           padding: EdgeInsets.all(15.0),
//                           shape: CircleBorder(),
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (index < 9)
//                     Container(
//                       height: 8,
//                       color: Colors.black,
//                     )
//                 ],
//               ),
//             );
//           }),
//     ));
//   }
// }

import 'package:flutter/material.dart';

import '../widgets/buildlistitem.dart';

void main() {
  runApp(TradepersonScreen());
}

class TradepersonScreen extends StatelessWidget {
  String selectedFilter = 'All';

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
