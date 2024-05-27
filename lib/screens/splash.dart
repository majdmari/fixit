// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fixit/constants.dart';
// import 'package:fixit/screens/login_screen.dart';
// import 'package:fixit/screens/register/user_model.dart';
// import 'package:fixit/widgets/admin_nav_bar.dart';
// import 'package:fixit/widgets/tradeperson_nav_bar.dart';
// import 'package:fixit/widgets/user_nav_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   static String id = 'SplashScreen';

//   @override
//   State<SplashScreen> createState() => _SplashState();
// }

// class _SplashState extends State<SplashScreen> {
//   @override
//   bool isTrue = false;
//   String email = '';

//   @override
//   void initState() {
//     super.initState();
//     initializeScreen();
//   }

//   Future<void> initializeScreen() async {
//     await sharedPrefData();

//     Timer(const Duration(seconds: 5), () async {
//       Navigator.pushNamed(context, LoginScreen.id);
//       if (isTrue && email.isNotEmpty) {
//         final registerViewModel =
//             Provider.of<RegisterViewModel>(context, listen: false);
//         registerViewModel.emailController.text = email;
//         DocumentSnapshot<Map<String, dynamic>> userSnapshot =
//             await FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(email)
//                 .get();

//         // Check if the user exists in the tradepersons collection
//         DocumentSnapshot<Map<String, dynamic>> tradepersonSnapshot =
//             await FirebaseFirestore.instance
//                 .collection('tradepersons')
//                 .doc(email)
//                 .get();

//         // Check if the user exists in the users collection
//         DocumentSnapshot<Map<String, dynamic>> adminSnapshot =
//             await FirebaseFirestore.instance
//                 .collection('admins')
//                 .doc(email)
//                 .get();
//         if (userSnapshot.exists) {
//           Navigator.pushNamed(context, UserNavigationScreen.id);
//         } else if (tradepersonSnapshot.exists) {
//           Navigator.pushNamed(context, TradepersonNavigationScreen.id);
//         } else if (adminSnapshot.exists) {
//           Navigator.pushNamed(context, AdminNavigationScreen.id);
//         }
//       } else {
//         Navigator.pushNamed(context, LoginScreen.id);
//       }
//     });
//   }

//   Future<void> sharedPrefData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isTrue = prefs.getBool('isLoggedIn') ?? false;
//       email = prefs.getString('email') ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       body: Center(
//         child: Container(
//           child: const Stack(
//             children: [
//               Center(
//                 child: Image(
//                   image: AssetImage(
//                     kLogo,
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:fixit/screens/welcom_secreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    initializeScreen();
  }

  Future<void> initializeScreen() async {
    await checkFirstTime();
    Timer(const Duration(seconds: 5), () {
      if (isFirstTime) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomScreen()),
        );
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    });
  }

  Future<void> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFirstTime = prefs.getBool('isFirstTime') ?? true;
      if (isFirstTime) {
        prefs.setBool('isFirstTime', false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          child: Stack(
            children: [
              Center(
                child: Image(
                  image: AssetImage(kLogo),
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
