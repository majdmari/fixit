import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/register_screen.dart';
import 'package:fixit/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Fixit());
}

class Fixit extends StatelessWidget {
  const Fixit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),

      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
      // initialRoute: SplashScreen.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
