import 'package:flutter/material.dart';

class PopupWidget extends StatelessWidget {
  final String? titleText;
  final String? contentText;
  final List<Widget> body;
  final TextStyle? textStyle;

  const PopupWidget({
    super.key,
    this.titleText,
    this.contentText,
    required this.body,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(insetPadding: const EdgeInsets.all(10), actions: body);
  }
}
