// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fixit/constants.dart';
// import 'package:fixit/helper/show_snack_bar.dart';
// import 'package:fixit/screens/favorite_list_screen.dart';
// import 'package:fixit/screens/home_page.dart';
// import 'package:fixit/screens/profile/tradeperson_profile.dart';
// import 'package:fixit/screens/profile/user_profile.dart';
// import 'package:fixit/screens/register/register_screen.dart';
// import 'package:fixit/screens/register/user_model.dart';
// import 'package:fixit/screens/welcom_secreen.dart';
// import 'package:fixit/widgets/custom_button.dart';
// import 'package:fixit/widgets/custom_text_field.dart';
// import 'package:fixit/widgets/nav_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// class LoginScreen extends StatefulWidget {
//   LoginScreen({super.key});
//   static String id = 'LoginScreen';

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   RegisterInfo registerInfo = RegisterInfo();
//   GlobalKey<FormState> formKey = GlobalKey();
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: isLoading,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text(
//             'Login',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//         ),
//         backgroundColor: KSurface,
//         body: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Form(
//             key: formKey,
//             child: ListView(
//               children: [
//                 Column(
//                   children: [
//                     CustomTextField(
//                       onChanged: (value) {
//                         registerInfo.email = value;
//                       },
//                       hintText: 'Type your email here',
//                       label: 'Email',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     CustomTextField(
//                       onChanged: (value) {
//                         registerInfo.password = value;
//                       },
//                       hintText: 'Type your password here',
//                       label: 'Password',
//                       obscureText: true,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, RegisterScreen.id);
//                         },
//                         child: Text(
//                           'Forget your Password?',
//                           style: TextStyle(
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     CustomButton(
//                       text: 'Login',
//                       onTap: () async {
//                         if (formKey.currentState!.validate()) {
//                           isLoading = true;
//                           setState(() {});
//                           try {
//                             await loginUser();
//                             // Navigator.pushNamed(context, ChatScreen.id,
//                             //     arguments: email);
//                             Navigator.pushNamed(context, NavigationScreen.id);
//                           } catch (ex) {
//                             showSnackBar(context,
//                                 'there was an error an Email or Password');
//                           }
//                           isLoading = false;
//                           setState(() {});
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Do not have an account?',
//                           style: TextStyle(
//                             color: Colors.grey,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, RegisterScreen.id);
//                           },
//                           child: Text(
//                             ' Register',
//                             style: TextStyle(
//                               color: KSecondary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> loginUser() async {
//     UserCredential user = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(
//             email: registerInfo.email!, password: registerInfo.password!);
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/helper/show_snack_bar.dart';
import 'package:fixit/screens/favorite_list_screen.dart';
import 'package:fixit/screens/home_page.dart';
import 'package:fixit/screens/profile/tradeperson_profile.dart';
import 'package:fixit/screens/profile/user_profile.dart';
import 'package:fixit/screens/register/register_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/screens/welcom_secreen.dart';
import 'package:fixit/widgets/admin_nav_bar.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:fixit/widgets/tradeperson_nav_bar.dart';
import 'package:fixit/widgets/user_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RegisterInfo registerInfo = RegisterInfo();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: KSurface,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    CustomTextField(
                      onChanged: (value) {
                        registerInfo.email = value;
                      },
                      hintText: 'Type your email here',
                      label: 'Email',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        registerInfo.password = value;
                      },
                      hintText: 'Type your password here',
                      label: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                        child: Text(
                          'Forget your Password?',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                      text: 'Login',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});

                          await loginUser();

                          isLoading = false;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Do not have an account?',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: Text(
                            ' Register',
                            style: TextStyle(
                              color: KSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: registerInfo.email!, password: registerInfo.password!);
      User? user = userCredential.user;

      // Check if the user exists in the users collection
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.email)
              .get();

      // Check if the user exists in the tradepersons collection
      DocumentSnapshot<Map<String, dynamic>> tradepersonSnapshot =
          await FirebaseFirestore.instance
              .collection('tradepersons')
              .doc(user.email)
              .get();

      // Check if the user exists in the users collection
      DocumentSnapshot<Map<String, dynamic>> adminSnapshot =
          await FirebaseFirestore.instance
              .collection('admins')
              .doc(user.email)
              .get();

      if (userSnapshot.exists) {
        // User exists in the users collection
        Navigator.pushNamed(context, UserNavigationScreen.id);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', registerInfo.email!);
      } else if (tradepersonSnapshot.exists) {
        // User exists in the tradepersons collection
        Navigator.pushNamed(context, TradepersonNavigationScreen.id);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', registerInfo.email!);
      } else if (adminSnapshot.exists) {
        // admin exists in the admins collection
        Navigator.pushNamed(context, AdminNavigationScreen.id);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', registerInfo.email!);
      } else {
        // User not found in either collection, handle accordingly
        // For example, show an error message
        showSnackBar(context, 'User not found.');
      }
    } catch (ex) {
      showSnackBar(context, 'There was an error with the email or password.');
    }
  }
}
