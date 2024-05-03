// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class PDFScreen extends StatelessWidget {
//   final String path;

//   const PDFScreen({Key? key, required this.path}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PDFView(
//       filePath: path,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatelessWidget {
  final String path;

  const PDFScreen({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}
