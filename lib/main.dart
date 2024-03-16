import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/register_screen.dart';
import 'package:fixit/screens/splash.dart';
import 'package:fixit/screens/tradeperson_list_screen.dart';
import 'package:fixit/screens/tradeperson_register_screen.dart';
import 'package:fixit/screens/user_register_screen.dart';
import 'package:fixit/screens/welcom_secreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Fixit());
}

class Fixit extends StatelessWidget {
  const Fixit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SplashScreen(),
      // home: WelcomScreen(),
      home: WelcomScreen(),

      routes: {
        WelcomScreen.id: (context) => WelcomScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        UserRegisterScreen.id: (context) => UserRegisterScreen(),
        TradepersonRegisterScreen.id: (context) => TradepersonRegisterScreen(),
        TradepersonListScreen.id: (context) => TradepersonListScreen(),
      },
      // initialRoute: SplashScreen.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
