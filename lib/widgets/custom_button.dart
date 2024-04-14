// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   CustomButton(
//       {this.onTap, required this.text, this.primaryColor = KSecondary,this.fontFamily=Kword});

//   VoidCallback? onTap;
//   String text;
//   Color primaryColor;
//   String fontFamily;

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: primaryColor,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         // width: double.infinity,
//         // height: 60,
//         width: screenSize.width * 0.9,
//         height: screenSize.height * 0.06,
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontFamily: fontFamily,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fixit/constants.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    this.onTap,
    required this.text,
    this.primaryColor = KSecondary,
    this.fontFamily = Kword,
  });

  final VoidCallback? onTap;
  final String text;
  final Color primaryColor;
  final String fontFamily;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late Color _flashColor;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _flashColor = widget.primaryColor;
    _timer = Timer(Duration.zero, () {}); // Initialize timer with a dummy value
  }

  void _flash() {
    setState(() {
      _flashColor = Colors.grey; // Change to white (flash color)
    });
    _timer.cancel(); // Cancel previous timer to avoid overlapping
    _timer = Timer(Duration(milliseconds: 100), () {
      // Return back to original color after 100 milliseconds
      setState(() {
        _flashColor = widget.primaryColor;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (_) {
        _flash(); // Call flash effect when tap down
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _flashColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.06,
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: widget.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
