import 'package:fixit/constants.dart';
import 'package:fixit/screens/admins/add_admin_screen.dart';
import 'package:fixit/screens/admins/add_traderperson.dart';
import 'package:fixit/screens/admins/admin_control_screen.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Home Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            CustomButton(
              text: 'Add Admin',
              onTap: () {
                Navigator.pushNamed(context, AddAdmin.id);
              },
            ),
            SizedBox(height: 25),
            CustomButton(
              text: 'Add Tradeperson',
              onTap: () {
                Navigator.pushNamed(context, AddTradeperson.id);
              },
            ),
            SizedBox(height: 25),
            CustomButton(
              text: 'Show All TradePersons',
              onTap: () {
                Navigator.pushNamed(context, AdminControlScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
