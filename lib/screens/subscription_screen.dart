// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:fixit/widgets/custom_button.dart';

// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({super.key});
//   static String id = 'SubscriptionScreen';

//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }

// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   String? _selectedSubscription;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Subscription Options',
//           style: TextStyle(color: Colors.white, fontFamily: Kword),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       backgroundColor: KSurface,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RadioListTile<String>(
//               title: const Text('Free Trial'),
//               value: 'free_trial',
//               groupValue: _selectedSubscription,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedSubscription = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Subscribe for \$100/year'),
//               value: 'paid_subscription',
//               groupValue: _selectedSubscription,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedSubscription = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             CustomButton(
//               text: 'Confirm',
//               onTap: () {
//                 if (_selectedSubscription == 'free_trial') {
//                   // Handle free trial subscription logic here
//                   print('Free Trial selected');
//                 } else if (_selectedSubscription == 'paid_subscription') {
//                   // Handle paid subscription logic here
//                   print('Paid Subscription selected');
//                 } else {
//                   // Handle no selection case
//                   print('No subscription selected');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:fixit/widgets/custom_button.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});
  static String id = 'SubscriptionScreen';

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String? _selectedSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Subscription Options',
          style: TextStyle(color: Colors.white, fontFamily: Kword),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: KSurface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile<String>(
              title: const Text(
                'Free Trial',
                style: TextStyle(color: Colors.white, fontFamily: Kword),
              ),
              subtitle: const Text(
                'Get a free trial for 7 days with limited features.',
                style: TextStyle(color: Colors.grey, fontFamily: Kword),
              ),
              value: 'free_trial',
              groupValue: _selectedSubscription,
              onChanged: (value) {
                setState(() {
                  _selectedSubscription = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text(
                'Subscribe for \$100/year',
                style: TextStyle(color: Colors.white, fontFamily: Kword),
              ),
              subtitle: const Text(
                'Get full access to all features for a year.',
                style: TextStyle(color: Colors.grey, fontFamily: Kword),
              ),
              value: 'paid_subscription',
              groupValue: _selectedSubscription,
              onChanged: (value) {
                setState(() {
                  _selectedSubscription = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: _selectedSubscription == 'paid_subscription'
                  ? 'Next'
                  : 'Confirm',
              onTap: () async {
                if (_selectedSubscription == 'free_trial') {
                  await updateSubscriptionStatus('no');
                  Navigator.pop(context);
                  // Handle free trial subscription logic here
                } else if (_selectedSubscription == 'paid_subscription') {
                  Navigator.pushNamed(context, PaymentScreen.id);

                  // Handle paid subscription logic here
                  print('Paid Subscription selected');
                } else {
                  // Handle no selection case
                  print('No subscription selected');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateSubscriptionStatus(String status) async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    if (email != null) {
      await FirebaseFirestore.instance
          .collection('tradepersons')
          .doc(email)
          .update({'isSubscribed': status});
    }
  }
}
