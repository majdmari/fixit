import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/firebase_options.dart';
import 'package:fixit/screens/admins/add_admin_screen.dart';
import 'package:fixit/screens/admins/add_category_screen.dart';
import 'package:fixit/screens/admins/add_traderperson.dart';
import 'package:fixit/screens/admins/admin_control_screen.dart';
import 'package:fixit/screens/admins/generate_report_screen.dart';
import 'package:fixit/screens/favorite_list_screen.dart';
import 'package:fixit/screens/home_page.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/payment_reg_screen.dart';
import 'package:fixit/screens/payment_screen.dart';
import 'package:fixit/screens/profile/tradeperson_profile.dart';
import 'package:fixit/screens/profile/user_profile.dart';
import 'package:fixit/screens/register/forger_pw_page.dart';
import 'package:fixit/screens/register/forget_pw_change_firestore_screen.dart';
import 'package:fixit/screens/register/register_screen.dart';
import 'package:fixit/screens/register/tradeperson_register_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/screens/register/user_register_screen.dart';
import 'package:fixit/screens/splash.dart';
import 'package:fixit/screens/subscription_reg_screen.dart';
import 'package:fixit/screens/subscription_screen.dart';
import 'package:fixit/screens/tradeperson_list_screen.dart';
import 'package:fixit/screens/welcom_secreen.dart';
import 'package:fixit/widgets/admin_nav_bar.dart';
import 'package:fixit/widgets/tradeperson_nav_bar.dart';
import 'package:fixit/widgets/user_nav_bar.dart';
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
      home: SplashScreen(),

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
        // WriteReviewScreen.id: (context) => WriteReviewScreen(),
        FavoriteListScreen.id: (context) => FavoriteListScreen(),
        UserNavigationScreen.id: (context) => UserNavigationScreen(),
        TradepersonNavigationScreen.id: (context) =>
            TradepersonNavigationScreen(),
        AdminNavigationScreen.id: (context) => AdminNavigationScreen(),
        AddAdmin.id: (context) => AddAdmin(),
        AddTradeperson.id: (context) => AddTradeperson(),
        AdminControlScreen.id: (context) => AdminControlScreen(),
        GenerateReportScreen.id: (context) => GenerateReportScreen(),
        Forgetpaswordpage.id: (context) => Forgetpaswordpage(),
        AddCategory.id: (context) => AddCategory(),
        SubscriptionScreen.id: (context) => SubscriptionScreen(),
        PaymentScreen.id: (context) => PaymentScreen(),
        ForgetPaswordChangeFirePage.id: (context) =>
            ForgetPaswordChangeFirePage(),
        PaymentRegScreen.id: (context) => PaymentRegScreen(),
        SubscriptionRegScreen.id: (context) => SubscriptionRegScreen(),
      },
      // initialRoute: SplashScreen.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
