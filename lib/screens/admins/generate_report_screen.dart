// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class GenerateReportScreen extends StatefulWidget {
//   static String id = 'GenerateReportScreen';

//   @override
//   State<GenerateReportScreen> createState() => _GenerateReportScreenState();
// }

// class _GenerateReportScreenState extends State<GenerateReportScreen> {
//   Map<String, int> tradePersonCount = {};

//   @override
//   void initState() {
//     super.initState();
//     // Call the function to calculate trade person count when the screen initializes
//     calculateTradePersonCount();
//   }

//   Future<void> calculateTradePersonCount() async {
//     // Fetch data from Firestore collection 'tradepersons'
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('tradepersons').get();

//     // Initialize the trade person count map
//     Map<String, int> tempTradePersonCount = {};

//     // Loop through the documents and count trade persons for each category
//     querySnapshot.docs.forEach((doc) {
//       var data = doc.data();
//       if (data != null &&
//           data is Map<String, dynamic> &&
//           data.containsKey('Category')) {
//         String category =
//             data['Category'] as String; // Explicitly cast to String
//         tempTradePersonCount.update(category, (value) => value + 1,
//             ifAbsent: () => 1);
//       }
//     });

//     // Update the state with the calculated trade person count
//     setState(() {
//       tradePersonCount = tempTradePersonCount;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KSurface,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Generate Report', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: tradePersonCount.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: tradePersonCount.length,
//               itemBuilder: (context, index) {
//                 var category = tradePersonCount.keys.elementAt(index);
//                 var count = tradePersonCount[category];
//                 return ListTile(
//                   title: Text(
//                     '$category',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   subtitle: Text('Trade Persons: $count',
//                       style: TextStyle(color: Colors.white)),
//                 );
//               },
//             ),
//     );
//   }
// }
// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// import 'package:pdf/widgets.dart' as pdf;

// class GenerateReportScreen extends StatefulWidget {
//   static String id = 'GenerateReportScreen';

//   @override
//   State<GenerateReportScreen> createState() => _GenerateReportScreenState();
// }

// class _GenerateReportScreenState extends State<GenerateReportScreen> {
//   Map<String, int> tradePersonCount = {};

//   @override
//   void initState() {
//     super.initState();
//     // Call the function to calculate trade person count when the screen initializes
//     calculateTradePersonCount();
//   }

//   Future<void> calculateTradePersonCount() async {
//     // Fetch data from Firestore collection 'tradepersons'
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('tradepersons').get();

//     // Initialize the trade person count map
//     Map<String, int> tempTradePersonCount = {};

//     // Loop through the documents and count trade persons for each category
//     querySnapshot.docs.forEach((doc) {
//       var data = doc.data();
//       if (data != null &&
//           data is Map<String, dynamic> &&
//           data.containsKey('Category')) {
//         String category =
//             data['Category'] as String; // Explicitly cast to String
//         tempTradePersonCount.update(category, (value) => value + 1,
//             ifAbsent: () => 1);
//       }
//     });

//     // Update the state with the calculated trade person count
//     setState(() {
//       tradePersonCount = tempTradePersonCount;
//     });
//   }

//   Future<void> _saveAsPdf() async {
//     final pdf.Document pdfDocument = pdf.Document();
//     // Add content to the PDF
//     tradePersonCount.forEach((category, count) {
//       pdfDocument.addPage(pdf.Page(
//         build: (context) => pdf.Center(
//           child: pdf.Text('$category - Trade Persons: $count'),
//         ),
//       ));
//     });

//     // Save the PDF to a file
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String path = '${directory.path}/report.pdf';
//     final File file = File(path);
//     await file.writeAsBytes(await pdfDocument.save());

//     // Show a message to the user that the PDF is saved
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('PDF saved successfully at $path'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KSurface,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Generate Report',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: tradePersonCount.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: tradePersonCount.length,
//               itemBuilder: (context, index) {
//                 var category = tradePersonCount.keys.elementAt(index);
//                 var count = tradePersonCount[category];
//                 return ListTile(
//                   title: Text(
//                     '$category',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   subtitle: Text('Trade Persons: $count',
//                       style: TextStyle(color: Colors.white)),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _saveAsPdf,
//         child: Icon(Icons.save),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }

// Future<void> _saveAsPdf() async {
//   final pdf.Document pdfDocument = pdf.Document();
//   // Add content to the PDF
//   tradePersonCount.forEach((category, count) {
//     pdfDocument.addPage(pdf.Page(
//       build: (context) => pdf.Center(
//         child: pdf.Text('$category - Trade Persons: $count'),
//       ),
//     ));
//   });

//   // Save the PDF to a file
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final String path = '${directory.path}/report.pdf';
//   final File file = File(path);
//   await file.writeAsBytes(await pdfDocument.save());

//   // Open the PDF file using the flutter_pdfview package
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (_) => PDFScreen(path: path),
//     ),
//   );

//   // Show a message to the user that the PDF is saved
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('PDF saved successfully at $path'),
//     ),
//   );
// }
// import 'package:fixit/constants.dart';
// import 'package:fixit/screens/admins/pdf_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:pdf/widgets.dart' as pdf;
// import 'package:open_file/open_file.dart'; // Import the open_file package
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class GenerateReportScreen extends StatefulWidget {
//   static String id = 'GenerateReportScreen';

//   @override
//   State<GenerateReportScreen> createState() => _GenerateReportScreenState();
// }

// class _GenerateReportScreenState extends State<GenerateReportScreen> {
//   Map<String, int> tradePersonCount = {};

//   @override
//   void initState() {
//     super.initState();
//     // Call the function to calculate trade person count when the screen initializes
//     calculateTradePersonCount();
//   }

//   Future<void> calculateTradePersonCount() async {
//     // Fetch data from Firestore collection 'tradepersons'
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('tradepersons').get();

//     // Initialize the trade person count map
//     Map<String, int> tempTradePersonCount = {};

//     // Loop through the documents and count trade persons for each category
//     querySnapshot.docs.forEach((doc) {
//       var data = doc.data();
//       if (data != null &&
//           data is Map<String, dynamic> &&
//           data.containsKey('Category')) {
//         String category =
//             data['Category'] as String; // Explicitly cast to String
//         tempTradePersonCount.update(category, (value) => value + 1,
//             ifAbsent: () => 1);
//       }
//     });

//     // Update the state with the calculated trade person count
//     setState(() {
//       tradePersonCount = tempTradePersonCount;
//     });
//   }

//   Future<void> _saveAsPdf() async {
//     final pdf.Document pdfDocument = pdf.Document();

//     // Define a TextStyle with larger font size
//     final pdf.TextStyle largeTextStyle = pdf.TextStyle(fontSize: 20);

//     // Add content to the PDF
//     pdfDocument.addPage(
//       pdf.Page(
//         build: (context) => pdf.Center(
//           // Use Column to display all content in the same page
//           child: pdf.Column(
//             mainAxisAlignment: pdf.MainAxisAlignment.center,
//             children: tradePersonCount.entries.map((entry) {
//               String category = entry.key;
//               int count = entry.value;
//               // Use RichText to apply TextStyle
//               return pdf.RichText(
//                 text: pdf.TextSpan(
//                   text: '$category - Trade Persons: $count\n',
//                   style: largeTextStyle,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );

//     // Save the PDF to a file
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String path = '${directory.path}/report.pdf';
//     final File file = File(path);
//     await file.writeAsBytes(await pdfDocument.save());

//     // Open the PDF file using the flutter_pdfview package
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => PDFScreen(path: path),
//       ),
//     );

//     // Show a message to the user that the PDF is saved
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('PDF saved successfully at $path'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KSurface,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Generate Report',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: tradePersonCount.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: tradePersonCount.length,
//               itemBuilder: (context, index) {
//                 var category = tradePersonCount.keys.elementAt(index);
//                 var count = tradePersonCount[category];
//                 return ListTile(
//                   title: Text(
//                     '$category',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   subtitle: Text('Trade Persons: $count',
//                       style: TextStyle(color: Colors.white)),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _saveAsPdf,
//         child: Icon(Icons.save),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/screens/admins/pdf_screen.dart';
import 'package:fixit/screens/register/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pdf;
import 'package:provider/provider.dart';

class GenerateReportScreen extends StatefulWidget {
  static String id = 'GenerateReportScreen';

  @override
  State<GenerateReportScreen> createState() => _GenerateReportScreenState();
}

class _GenerateReportScreenState extends State<GenerateReportScreen> {
  Map<String, int> tradePersonCount = {};

  @override
  void initState() {
    super.initState();
    // Call the function to calculate trade person count when the screen initializes
    calculateTradePersonCount();
  }

  Future<void> calculateTradePersonCount() async {
    // Fetch data from Firestore collection 'tradepersons'
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('tradepersons').get();

    // Initialize the trade person count map
    Map<String, int> tempTradePersonCount = {};

    // Loop through the documents and count trade persons for each category
    querySnapshot.docs.forEach((doc) {
      var data = doc.data();
      if (data != null &&
          data is Map<String, dynamic> &&
          data.containsKey('Category')) {
        String category =
            data['Category'] as String; // Explicitly cast to String
        tempTradePersonCount.update(category, (value) => value + 1,
            ifAbsent: () => 1);
      }
    });

    // Update the state with the calculated trade person count
    setState(() {
      tradePersonCount = tempTradePersonCount;
    });
  }

  Future<void>? _saveAsPdf(String? email) async {
    // Fetch the email of the admin from Firestore
    final String adminEmail = await _fetchAdminEmail();

    final pdf.Document pdfDocument = pdf.Document();

    // Define a TextStyle with larger font size
    final pdf.TextStyle largeTextStyle = pdf.TextStyle(fontSize: 20);

    // Get current date and time
    final String currentDate = DateTime.now().toIso8601String();

    // Add content to the PDF
    pdfDocument.addPage(
      pdf.Page(
        build: (context) => pdf.Center(
          // Use Column to display all content in the same page
          child: pdf.Column(
            mainAxisAlignment: pdf.MainAxisAlignment.center,
            children: [
              pdf.RichText(
                text: pdf.TextSpan(
                  text: 'Generated Report\n\n',
                  style: largeTextStyle,
                ),
              ),
              pdf.RichText(
                text: pdf.TextSpan(
                  text: 'Date: $currentDate\n',
                  style: largeTextStyle,
                ),
              ),
              pdf.RichText(
                text: pdf.TextSpan(
                  text: 'Admin Email: $email\n\n',
                  style: largeTextStyle,
                ),
              ),
              ...tradePersonCount.entries.map((entry) {
                String category = entry.key;
                int count = entry.value;
                // Use RichText to apply TextStyle
                return pdf.RichText(
                  text: pdf.TextSpan(
                    text: '$category - TradePersons: $count\n',
                    style: largeTextStyle,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );

    // Generate a unique filename based on the current timestamp
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd_HH-mm-ss');
    final String timestamp = formatter.format(now);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/Tradepersons Report _$timestamp.pdf';

    final File file = File(path);
    await file.writeAsBytes(await pdfDocument.save());

    // Show a message to the user that the PDF is saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF saved successfully at $path'),
      ),
    );
  }

// Function to fetch admin email from Firestore

  Future<String> _fetchAdminEmail() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email ?? ''; // Return the user's email if available
    } else {
      // Handle the case when user is not authenticated or user data is not available
      throw Exception('User not authenticated');
    }
  }

  Future<void> _loadPdfFiles() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = directory.listSync();
    final List<String> pdfPaths = [];

    for (var file in files) {
      if (file.path.endsWith('.pdf')) {
        pdfPaths.add(file.path);
      }
    }

    // Show a dialog with a list of PDF files to choose from
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select PDF to Open'),
        content: SingleChildScrollView(
          child: Column(
            children: pdfPaths.map((path) {
              return ListTile(
                title: Text(path.split('/').last), // Display only the file name
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PDFScreen(path: path),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);
    return Scaffold(
      backgroundColor: KSurface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Generate Report',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: tradePersonCount.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: tradePersonCount.length,
              itemBuilder: (context, index) {
                var category = tradePersonCount.keys.elementAt(index);
                var count = tradePersonCount[category];
                return ListTile(
                  title: Text(
                    '$category',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text('Trade Persons: $count',
                      style: TextStyle(color: Colors.white)),
                );
              },
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await _saveAsPdf(registerViewModel.emailController.text);
            },
            child: Icon(Icons.save),
            backgroundColor: Colors.blue,
            heroTag:
                null, // Set heroTag to null to avoid conflicts if there are multiple floating action buttons
          ),
          SizedBox(width: 16), // Add some space between the buttons
          FloatingActionButton(
            onPressed: _loadPdfFiles,
            child: Icon(Icons.folder_open),
            backgroundColor: Colors.green,
            heroTag:
                null, // Set heroTag to null to avoid conflicts if there are multiple floating action buttons
          ),
        ],
      ),
    );
  }
}
