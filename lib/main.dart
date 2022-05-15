import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splenda_epi/screens/day_details_screen.dart';
import 'package:splenda_epi/screens/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 254, 204, 22)));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splenda EPI',
      theme: ThemeData(primarySwatch: Colors.yellow, fontFamily: 'Roboto'),
      home: const LoginScreen(),
      routes: {"/day_details_screen": ((context) => const DayDetailsScreen())},
    );
  }
}
