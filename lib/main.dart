import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/firebase_options.dart';
import 'package:fixit/screens/home_page.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/profile/tradeperson_profile.dart';
import 'package:fixit/screens/profile/user_profile.dart';
import 'package:fixit/screens/register/register_screen.dart';
import 'package:fixit/screens/register/tradeperson_register_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/screens/register/user_register_screen.dart';
import 'package:fixit/screens/splash.dart';
import 'package:fixit/screens/tradeperson_list_screen.dart';
import 'package:fixit/screens/user_writeReview_screen.dart';
import 'package:fixit/screens/welcom_secreen.dart';
import 'package:fixit/widgets/s.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RegisterViewModel())],
      child: const Fixit()));
}

class Fixit extends StatelessWidget {
  const Fixit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginScreen(),
      // home: MyWidget(),
      // home: TradepersonListScreen(),
      home: WriteReviewScreen(),

      routes: {
        WelcomScreen.id: (context) => WelcomScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        UserRegisterScreen.id: (context) => UserRegisterScreen(),
        TradepersonRegisterScreen.id: (context) => TradepersonRegisterScreen(),
        UserProfileScreen.id: (context) => UserProfileScreen(),
        TradepersonProfileScreen.id: (context) => TradepersonProfileScreen(),
        TradepersonListScreen.id: (context) => TradepersonListScreen(),
        Homepage.id: (context) => Homepage(),
        WriteReviewScreen.id: (context) => WriteReviewScreen(),
      },
      // initialRoute: SplashScreen.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
