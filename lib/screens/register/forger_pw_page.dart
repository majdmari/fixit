import 'package:fixit/constants.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:fixit/screens/register/forget_pw_change_firestore_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:fixit/widgets/custom_alert_message.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/helper/show_snack_bar.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Forgetpaswordpage extends StatefulWidget {
  const Forgetpaswordpage({super.key});
  static String id = 'Forgetpaswordpage';

  @override
  State<Forgetpaswordpage> createState() => _ForgetpaswordpageState();
}

class _ForgetpaswordpageState extends State<Forgetpaswordpage> {
  RegisterInfo registerInfo = RegisterInfo();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forget Password'),
          backgroundColor: Color(0XffB73B67),
        ),
        backgroundColor: KSurface,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  'Enter your email and we will send you a password reset link',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: registerViewModel.emailController,
                  onChanged: (value) {
                    registerInfo.email = value;
                  },
                  hintText: 'Type your email here',
                  label: 'Email',
                ),
                SizedBox(
                  height: 16,
                ),
                // CustomButton(
                //   text: 'reset password',
                //   onTap: () async {
                //     await FirebaseAuth.instance
                //         .sendPasswordResetEmail(email: registerInfo.email!);
                //     showCustomDialog(
                //         context, 'Check your email inbox .', 'Rest Password');
                //     Navigator.pushNamed(context, LoginScreen.id);
                //   },
                // ),
                CustomButton(
                  text: 'Reset Password',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (registerInfo.email == null) {
                        showCustomDialog(
                            context, "You can't leave Email empty.", 'error');
                        return;
                      }
                      isLoading = true;
                      setState(() {});

                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: registerInfo.email!);
                      isLoading = false;
                      setState(() {});
                      await showCustomDialog(
                          context, 'Check your email inbox.', 'Rest Password');
                      Navigator.pushNamed(
                          context, ForgetPasswordChangeFirePage.id);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showCustomDialog(
      BuildContext context, String message, String title) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          message: message,
          title: title,
        );
      },
    );
  }
}
