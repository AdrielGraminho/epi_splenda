import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isPassword;
  final String label;

  const BaseTextField({
    Key? key,
    required this.controller,
    this.isPassword,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword != null,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), hintText: label),
      controller: controller,
    );
  }
}
