import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoxFieldDate extends StatelessWidget {
  final DateTime dateField;

  const BoxFieldDate({Key? key, required this.dateField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          DateFormat("dd/MM/yyyy").format(dateField),
        ),
      ),
    );
  }
}
