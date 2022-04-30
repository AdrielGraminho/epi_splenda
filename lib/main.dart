import 'package:flutter/material.dart';
import 'package:splenda_epi/screens/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splenda EPI',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const LoginScreen(),
    );
  }
}
