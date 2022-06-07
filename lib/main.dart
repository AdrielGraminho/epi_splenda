import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/providers/business_unit_provider.dart';
import 'package:splenda_epi/providers/calendar_days_provider.dart';
import 'package:splenda_epi/providers/calendar_details_provider.dart';
import 'package:splenda_epi/providers/count_page.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => CountPage(),
          ),
          ChangeNotifierProvider(
              create: (BuildContext context) => CalendarDays()),
          ChangeNotifierProvider(
              create: (BuildContext context) => CalendarDetailsProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => BusinessUnitProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Splenda EPI',
          theme: ThemeData(primarySwatch: Colors.yellow, fontFamily: 'Roboto'),
          home: const LoginScreen(),
          routes: {
            "/day_details_screen": ((context) => const DayDetailsScreen())
          },
        ));
  }
}
