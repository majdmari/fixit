import 'package:fixit/constants.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/helper/show_snack_bar.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Forgetpaswordpage extends StatefulWidget {
  const Forgetpaswordpage({super.key});
  static String id = 'Forgetpaswordpage';

  @override
  State<Forgetpaswordpage> createState() => _ForgetpaswordpageState();
}

class _ForgetpaswordpageState extends State<Forgetpaswordpage> {
  RegisterInfo registerInfo = RegisterInfo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forget Password'),
          backgroundColor: Color(0XffB73B67),
        ),
        backgroundColor: KSurface,
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
                child: ListView(children: [
              Text(
                'Enter your email and we will send you a password reset link',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 16),
              CustomTextField(
                onChanged: (value) {
                  registerInfo.email = value;
                },
                hintText: 'Type your email here',
                label: 'Email',
              ),
              SizedBox(
                height: 16,
              ),
              CustomButton(
                  text: 'reset password',
                  onTap: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: registerInfo.email!);
                    Navigator.pushNamed(context, LoginScreen.id);
                  }),
            ]))));
  }
}
