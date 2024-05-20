// import 'package:fixit/constants.dart';
// import 'package:fixit/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:fixit/widgets/custom_text_field.dart'; // Ensure this is the correct path to your CustomTextField

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//   static String id = 'PaymentScreen';

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   GlobalKey<FormState> formKey = GlobalKey();
//   final TextEditingController visaController = TextEditingController();
//   final TextEditingController expDateController = TextEditingController();
//   final TextEditingController cvvController = TextEditingController();

//   @override
//   void dispose() {
//     visaController.dispose();
//     expDateController.dispose();
//     cvvController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Payment Information',
//           style: TextStyle(color: Colors.white, fontFamily: Kword),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface, // Adjust to your theme
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomTextField(
//                 controller: visaController,
//                 label: 'VISA Number',
//                 hintText: 'Enter your VISA number',
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   // Handle VISA number change
//                 },
//               ),
//               SizedBox(height: 20),
//               CustomTextField(
//                 controller: expDateController,
//                 label: 'Expiration Date',
//                 hintText: 'MM/YY',
//                 keyboardType: TextInputType.datetime,
//                 onChanged: (value) {
//                   // Handle expiration date change
//                 },
//               ),
//               SizedBox(height: 20),
//               CustomTextField(
//                 controller: cvvController,
//                 label: 'CVV',
//                 hintText: 'Enter your CVV',
//                 obscureText: true,
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   // Handle CVV change
//                 },
//               ),
//               SizedBox(height: 40),
//               CustomButton(
//                 text: "Done",
//                 onTap: () {
//                   if (formKey.currentState!.validate()) {}
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:fixit/constants.dart';
import 'package:fixit/screens/profile/tradeperson_profile.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static String id = 'PaymentScreen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController visaController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    visaController.dispose();
    expDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  Future<void> savePaymentInformation() async {
    final user = _auth.currentUser;
    if (user != null) {
      final email = user.email;
      final paymentInfoRef =
          _firestore.collection('paymentInformation').doc(email);
      final tradepersonsRef = _firestore.collection('tradepersons').doc(email);

      await _firestore.runTransaction((transaction) async {
        // Add payment information
        transaction.set(paymentInfoRef, {
          'visaNumber': visaController.text,
          'expirationDate': expDateController.text,
          'cvv': cvvController.text,
          'email': email,
        });

        // Update subscription status in tradepersons
        transaction.update(tradepersonsRef, {
          'isSubscribed': 'yes',
        });
      });

      print('Payment information and subscription status saved');
    } else {
      print('No user is signed in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Payment Information',
          style: TextStyle(color: Colors.white, fontFamily: Kword),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface, // Adjust to your theme
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: visaController,
                label: 'VISA Number',
                hintText: 'Enter your VISA number',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Handle VISA number change
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: expDateController,
                label: 'Expiration Date',
                hintText: 'MM/YY',
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  // Handle expiration date change
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: cvvController,
                label: 'CVV',
                hintText: 'Enter your CVV',
                obscureText: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Handle CVV change
                },
              ),
              SizedBox(height: 40),
              CustomButton(
                text: "Done",
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await savePaymentInformation();
                    // Navigate back or show a success message
                    Navigator.pushNamed(context, TradepersonProfileScreen.id);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
