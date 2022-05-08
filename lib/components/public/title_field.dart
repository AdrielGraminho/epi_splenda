import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final String title;
  const TitleField({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
