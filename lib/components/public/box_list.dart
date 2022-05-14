import 'package:flutter/material.dart';

class BoxList extends StatelessWidget {
  final Widget child;
  final String title;

  const BoxList({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: const Color.fromARGB(255, 254, 204, 22)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              child,
            ])));
  }
}
