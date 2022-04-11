import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final String text;
  final Function onChange;
  final bool? isPassword;

  const BaseTextField({
    Key? key,
    required this.text,
    required this.onChange,
    this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword != null,
      decoration: InputDecoration(border: OutlineInputBorder(), hintText: text),
      onChanged: (_) => onChange(),
    );
  }
}
