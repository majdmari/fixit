import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/login_screen.dart';
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

class ForgetPaswordChangeFirePage extends StatefulWidget {
  const ForgetPaswordChangeFirePage({super.key});
  static String id = 'ForgetPaswordChangeFirePage';

  @override
  State<ForgetPaswordChangeFirePage> createState() =>
      _ForgetPaswordChangeFirePageState();
}

class _ForgetPaswordChangeFirePageState
    extends State<ForgetPaswordChangeFirePage> {
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
          title: Text('Change Password'),
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
                  'Type the password you just changed from your browser.',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  onChanged: (value) {
                    registerInfo.password = value;
                  },
                  hintText: 'Type your new password here',
                  label: 'Password',
                ),
                SizedBox(
                  height: 16,
                ),
                CustomButton(
                  text: 'Change Password',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (registerInfo.password == null) {
                        showCustomDialog(context,
                            "You can't leave Password empty.", 'error');
                        return;
                      }
                      isLoading = true;
                      setState(() {});

                      Map<String, dynamic> password = {
                        'Password': registerInfo.password,
                      };
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(registerViewModel.emailController.text)
                          .update(password);
                      isLoading = false;
                      setState(() {});
                      await showCustomDialog(
                          context,
                          'your password change successfully .',
                          'Change Password');
                      registerViewModel.emailController.text = '';

                      Navigator.pushNamed(context, LoginScreen.id);
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
