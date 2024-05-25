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
// import 'package:fixit/constants.dart';
// import 'package:fixit/screens/profile/tradeperson_profile.dart';
// import 'package:fixit/widgets/custom_button.dart';
// import 'package:fixit/widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//   static String id = 'PaymentScreen';

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   final TextEditingController visaController = TextEditingController();
//   final TextEditingController expDateController = TextEditingController();
//   final TextEditingController cvvController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   void dispose() {
//     visaController.dispose();
//     expDateController.dispose();
//     cvvController.dispose();
//     super.dispose();
//   }

//   Future<void> savePaymentInformation() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final email = user.email;
//       final paymentInfoRef =
//           _firestore.collection('paymentInformation').doc(email);
//       final tradepersonsRef = _firestore.collection('tradepersons').doc(email);

//       await _firestore.runTransaction((transaction) async {
//         // Add payment information
//         transaction.set(paymentInfoRef, {
//           'visaNumber': visaController.text,
//           'expirationDate': expDateController.text,
//           'cvv': cvvController.text,
//           'email': email,
//         });

//         // Update subscription status in tradepersons
//         transaction.update(tradepersonsRef, {
//           'isSubscribed': 'yes',
//         });
//       });

//       print('Payment information and subscription status saved');
//     } else {
//       print('No user is signed in');
//     }
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
//                 onTap: () async {
//                   if (formKey.currentState!.validate()) {
//                     await savePaymentInformation();
//                     // Navigate back or show a success message
//                     // Navigator.pushNamed(context, TradepersonProfileScreen.id);
//                     Navigator.pop(context);
//                     Navigator.pop(context, true);
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:fixit/constants.dart';
// import 'package:fixit/widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//   static String id = 'PaymentScreen';

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   final TextEditingController visaController = TextEditingController();
//   final TextEditingController expDateController = TextEditingController();
//   final TextEditingController cvvController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   void dispose() {
//     visaController.dispose();
//     expDateController.dispose();
//     cvvController.dispose();
//     super.dispose();
//   }

//   Future<void> savePaymentInformation() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final email = user.email;
//       final paymentInfoRef =
//           _firestore.collection('paymentInformation').doc(email);
//       final tradepersonsRef = _firestore.collection('tradepersons').doc(email);

//       await _firestore.runTransaction((transaction) async {
//         // Add payment information
//         transaction.set(paymentInfoRef, {
//           'visaNumber': visaController.text,
//           'expirationDate': expDateController.text,
//           'cvv': cvvController.text,
//           'email': email,
//         });

//         // Update subscription status in tradepersons
//         transaction.update(tradepersonsRef, {
//           'isSubscribed': 'yes',
//         });
//       });

//       print('Payment information and subscription status saved');
//     } else {
//       print('No user is signed in');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Payment Information',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface,
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
//                 validator: (value) {
//                   if (value!.isEmpty ||
//                       value.replaceAll(' ', '').length != 16) {
//                     return 'Please enter a valid VISA number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               CustomTextField(
//                 controller: expDateController,
//                 label: 'Expiration Date',
//                 hintText: 'MM/YY',
//                 keyboardType: TextInputType.datetime,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the expiration date';
//                   }
//                   // Split the date into month and year
//                   final parts = value.split('/');
//                   if (parts.length != 2) {
//                     return 'Invalid date format';
//                   }
//                   final month = int.tryParse(parts[0]);
//                   final year = int.tryParse(parts[1]);
//                   if (month == null ||
//                       year == null ||
//                       month < 1 ||
//                       month > 12 ||
//                       year < 0 || // Ensure year is a positive number
//                       year < 1900 || // Ensure year is greater than 1900
//                       year > DateTime.now().year) {
//                     // Ensure year is not greater than current year
//                     return 'Please enter a valid expiration date';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               CustomTextField(
//                 controller: cvvController,
//                 label: 'CVV',
//                 hintText: 'Enter your CVV',
//                 obscureText: true,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty || value.length != 3) {
//                     return 'Please enter a valid CVV';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     await savePaymentInformation();
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: Text('Done'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:fixit/constants.dart';
// import 'package:fixit/widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//   static String id = 'PaymentScreen';

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   final TextEditingController visaController = TextEditingController();
//   final TextEditingController expDateController = TextEditingController();
//   final TextEditingController cvvController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   void dispose() {
//     visaController.dispose();
//     expDateController.dispose();
//     cvvController.dispose();
//     super.dispose();
//   }

//   Future<void> savePaymentInformation() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final email = user.email;
//       final paymentInfoRef =
//           _firestore.collection('paymentInformation').doc(email);
//       final tradepersonsRef = _firestore.collection('tradepersons').doc(email);

//       await _firestore.runTransaction((transaction) async {
//         // Add payment information
//         transaction.set(paymentInfoRef, {
//           'visaNumber': visaController.text,
//           'expirationDate': expDateController.text,
//           'cvv': cvvController.text,
//           'email': email,
//         });

//         // Update subscription status in tradepersons
//         transaction.update(tradepersonsRef, {
//           'isSubscribed': 'yes',
//         });
//       });

//       print('Payment information and subscription status saved');
//     } else {
//       print('No user is signed in');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Payment Information',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface,
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
//                 validator: (value) {
//                   if (value!.isEmpty ||
//                       value.replaceAll(' ', '').length != 16) {
//                     return 'Please enter a valid VISA number';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   if (value.length == 4 ||
//                       value.length == 9 ||
//                       value.length == 14) {
//                     visaController.text = value + ' ';
//                     visaController.selection = TextSelection.fromPosition(
//                       TextPosition(offset: visaController.text.length),
//                     );
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               CustomTextField(
//                 controller: expDateController,
//                 label: 'Expiration Date',
//                 hintText: 'MM/YY',
//                 keyboardType: TextInputType.datetime,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the expiration date';
//                   }
//                   // Check if the format matches MM/YY
//                   if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
//                     return 'Invalid date format';
//                   }
//                   // Split the date into month and year
//                   final parts = value.split('/');
//                   final month = int.tryParse(parts[0]);
//                   final year = int.tryParse(parts[1]);
//                   if (month == null ||
//                       year == null ||
//                       month < 1 ||
//                       month > 12 ||
//                       year < 0 || // Ensure year is a positive number
//                       year < 1900 || // Ensure year is greater than 1900
//                       year > DateTime.now().year) {
//                     // Ensure year is not greater than current year
//                     return 'Please enter a valid expiration date';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               CustomTextField(
//                 controller: cvvController,
//                 label: 'CVV',
//                 hintText: 'Enter your CVV',
//                 obscureText: true,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty || value.length != 3) {
//                     return 'Please enter a valid CVV';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     await savePaymentInformation();
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: Text('Done'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:fixit/constants.dart';
// import 'package:fixit/widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//   static String id = 'PaymentScreen';

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   final TextEditingController visaController = TextEditingController();
//   final TextEditingController expDateController = TextEditingController();
//   final TextEditingController cvvController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   void dispose() {
//     visaController.dispose();
//     expDateController.dispose();
//     cvvController.dispose();
//     super.dispose();
//   }

//   Future<void> savePaymentInformation() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final email = user.email;
//       final paymentInfoRef =
//           _firestore.collection('paymentInformation').doc(email);
//       final tradepersonsRef = _firestore.collection('tradepersons').doc(email);

//       await _firestore.runTransaction((transaction) async {
//         // Add payment information
//         transaction.set(paymentInfoRef, {
//           'visaNumber': visaController.text,
//           'expirationDate': expDateController.text,
//           'cvv': cvvController.text,
//           'email': email,
//         });

//         // Update subscription status in tradepersons
//         transaction.update(tradepersonsRef, {
//           'isSubscribed': 'yes',
//         });
//       });

//       print('Payment information and subscription status saved');
//     } else {
//       print('No user is signed in');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Payment Information',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface,
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
//                   // Remove any spaces from the value
//                   String cardNumber = value.replaceAll(' ', '');
//                   // Limit the input to 16 characters
//                   if (cardNumber.length > 16) {
//                     cardNumber = cardNumber.substring(0, 16);
//                   }
//                   // Add spaces after every 4 characters
//                   String formattedCardNumber = '';
//                   for (int i = 0; i < cardNumber.length; i++) {
//                     if (i > 0 && i % 4 == 0) {
//                       formattedCardNumber += ' ';
//                     }
//                     formattedCardNumber += cardNumber[i];
//                   }
//                   // Update the controller with the formatted value
//                   visaController.value = TextEditingValue(
//                     text: formattedCardNumber,
//                     selection: TextSelection.collapsed(
//                         offset: formattedCardNumber.length),
//                   );
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty ||
//                       value.replaceAll(' ', '').length != 16) {
//                     return 'Please enter a valid VISA number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               CustomTextField(
//                 controller: expDateController,
//                 label: 'Expiration Date',
//                 hintText: 'MM/YY',
//                 keyboardType: TextInputType.datetime,
//                 onChanged: (value) {
//                   // Auto-insert '/' after 2 characters
//                   if (value.length == 2 && !value.contains('/')) {
//                     expDateController.text = value + '/';
//                     expDateController.selection = TextSelection.fromPosition(
//                         TextPosition(offset: expDateController.text.length));
//                   }
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the expiration date';
//                   }
//                   // Split the date into month and year
//                   final parts = value.split('/');
//                   if (parts.length != 2) {
//                     return 'Invalid date format';
//                   }
//                   final month = int.tryParse(parts[0]);
//                   final year = int.tryParse(parts[1]);
//                   if (month == null ||
//                       year == null ||
//                       month < 1 ||
//                       month > 12 ||
//                       year < 0 || // Ensure year is a positive number
//                       year < 1900 || // Ensure year is greater than 1900
//                       year > DateTime.now().year) {
//                     // Ensure year is not greater than current year
//                     return 'Please enter a valid expiration date';
//                   }
//                   return null;
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
//                   // Limit the input to 3 characters
//                   if (value.length > 3) {
//                     cvvController.text = value.substring(0, 3);
//                   }
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty || value.length != 3) {
//                     return 'Please enter a valid CVV';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     await savePaymentInformation();
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: Text('Done'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_button.dart';
import 'package:fixit/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface,
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
                  // Remove any spaces from the value
                  String cardNumber = value.replaceAll(' ', '');
                  // Limit the input to 16 characters
                  if (cardNumber.length > 16) {
                    cardNumber = cardNumber.substring(0, 16);
                  }
                  // Add spaces after every 4 characters
                  String formattedCardNumber = '';
                  for (int i = 0; i < cardNumber.length; i++) {
                    if (i > 0 && i % 4 == 0) {
                      formattedCardNumber += ' ';
                    }
                    formattedCardNumber += cardNumber[i];
                  }
                  // Update the controller with the formatted value
                  visaController.value = TextEditingValue(
                    text: formattedCardNumber,
                    selection: TextSelection.collapsed(
                        offset: formattedCardNumber.length),
                  );
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      value.replaceAll(' ', '').length != 16) {
                    return 'Please enter a valid VISA number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: expDateController,
                label: 'Expiration Date',
                hintText: 'MM/YYYY',
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  // Auto-insert '/' after 2 characters
                  if (value.length == 2 && !value.contains('/')) {
                    expDateController.text = value + '/';
                    expDateController.selection = TextSelection.fromPosition(
                        TextPosition(offset: expDateController.text.length));
                  }
                  // Limit the input to 7 characters (MM/YYYY)
                  if (value.length > 7) {
                    expDateController.text = value.substring(0, 7);
                    expDateController.selection = TextSelection.fromPosition(
                        TextPosition(offset: expDateController.text.length));
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the expiration date';
                  }
                  // Split the date into month and year
                  final parts = value.split('/');
                  if (parts.length != 2) {
                    return 'Invalid date format';
                  }
                  final month = int.tryParse(parts[0]);
                  final year = int.tryParse(parts[1]);
                  if (month == null ||
                      year == null ||
                      month < 1 ||
                      month > 12 ||
                      year < 0 || // Ensure year is a positive number
                      year < 1900 || // Ensure year is greater than 1900
                      year > DateTime.now().year) {
                    // Ensure year is not greater than current year
                    return 'Please enter a valid expiration date';
                  }
                  return null;
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
                  // Limit the input to 3 characters
                  if (value.length > 3) {
                    cvvController.text = value.substring(0, 3);
                    cvvController.selection = TextSelection.fromPosition(
                        TextPosition(offset: cvvController.text.length));
                  }
                },
                validator: (value) {
                  if (value!.isEmpty || value.length != 3) {
                    return 'Please enter a valid CVV';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await savePaymentInformation();
                    Navigator.pop(context);

                    Navigator.pop(context, true);
                  }
                },
                text: 'Done',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
