import 'package:flutter/material.dart';

class CustomTextLabel extends StatelessWidget {
  final String text;
  const CustomTextLabel({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
        ));
  }
}
