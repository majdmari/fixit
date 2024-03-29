import 'package:flutter/material.dart';
import 'info.dart';

class Buildlistitem extends StatefulWidget {
  const Buildlistitem({Key? key}) : super(key: key);

  @override
  State<Buildlistitem> createState() => _BuildlistitemState();
}

class _BuildlistitemState extends State<Buildlistitem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0Xff2B2831),
        ),
        height: 100,
        child: Info(),
      ),
    );
  }
}
