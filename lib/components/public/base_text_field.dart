import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isPassword;
  final String label;
  final bool? isDisabled;
  final Function(String)? onChange;

  const BaseTextField({
    Key? key,
    required this.controller,
    this.isPassword,
    required this.label,
    this.isDisabled,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleChanged(String value) {
      if (onChange != null) {
        onChange!(value);
      }
    }

    return TextField(
      obscureText: isPassword != null || isPassword == true,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), hintText: label),
      controller: controller,
      enabled: isDisabled == false || isDisabled == null,
      onChanged: (value) => handleChanged(value),
    );
  }
}
