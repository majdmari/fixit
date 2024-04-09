// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';

// class CustomCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       color: KSf2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AspectRatio(
//             aspectRatio: 2,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(15.0),
//               child: Image.asset(
//                 'assets/images/carprenter.png',
//                 fit: BoxFit.cover, // Ensure the image fills the available space
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 5),
//             child: Text(
//               'Carpenter',
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//       child: Stack(
//         children: [
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Carpenter',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   SizedBox(
//                     height: 1,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15.0),
//             child: Image.asset(
//               'assets/images/carprenter.png',
//               height: 100,
//               width: 200,
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fixit/constants.dart';

class CustomCard extends StatelessWidget {
  final String title; // Title for the card

  const CustomCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KSf2,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                'assets/images/home.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
