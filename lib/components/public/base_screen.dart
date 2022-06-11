import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/providers/count_page.dart';
import 'package:splenda_epi/screens/account_screen.dart';
import 'package:splenda_epi/screens/audit_screen.dart';
import 'package:splenda_epi/screens/recived_epi_screen.dart';
import 'package:splenda_epi/screens/send_epi_screen.dart';
import 'package:splenda_epi/screens/ppra_pcmso_screen.dart';

import '../../models/account_details.dart';
import '../../providers/account_details_provider.dart';
import '../../screens/calendar_screen.dart';
import '../../shared/data/store.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final bool? navigation;
  final bool? topBar;
  const BaseScreen(
      {Key? key, required this.child, this.navigation, this.topBar})
      : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    AccountDetails? accountDetails =
        Provider.of<AccountDetailsProvider>(context, listen: false)
            .accountDetails;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    List<Widget> pages = [
      const CalendarScreen(),
      const RecivedEpiScreen(),
      const SendEpiScreen()
    ];

    int _selectedIndex = Provider.of<CountPage>(context, listen: false).counter;

    void _onItemTapped(int index) {
      setState(() {
        Provider.of<CountPage>(context, listen: false).incrementCounter(index);
      });
      Navigator.push(context, PageRouteBuilder(pageBuilder:
          (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
        return pages.elementAt(index);
      }));
    }

    bool isNavigationScreen() {
      if (widget.navigation == true) {
        return true;
      } else {
        return false;
      }
    }

    bool isTopBarScreen() {
      if (widget.topBar == false) {
        return false;
      } else {
        return true;
      }
    }

    return Container(
      padding:
          isNavigationScreen() ? null : EdgeInsets.only(top: statusBarHeight),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.white,
            Color.fromARGB(255, 254, 204, 22),
          ],
              stops: [
            0.6,
            1
          ])),
      child: Scaffold(
        appBar: isTopBarScreen()
            ? AppBar(
                title: const Text("Controle de EPIs Splenda"),
                backgroundColor: const Color.fromARGB(255, 254, 204, 22),
              )
            : null,
        drawer: isNavigationScreen()
            ? Drawer(
                backgroundColor: const Color.fromARGB(255, 254, 204, 22),
                child: ListView(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  children: [
                    ListTile(
                      title: const Text('Início'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalendarScreen()),
                      ),
                    ),
                    ListTile(
                      title: const Text('Conta'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountScreen()),
                      ),
                    ),
                    accountDetails?.nameRole == 'total'
                        ? ListTile(
                            title: const Text('Auditoria'),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AuditScreen()),
                            ),
                          )
                        : Text(''),
                    accountDetails?.nameRole == 'total'
                        ? ListTile(
                            title: const Text('PPRA e PCMSO'),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PpraPcmsoScreen()),
                            ),
                          )
                        : Text(''),
                  ],
                ),
              )
            : null,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: widget.child,
        ),
        bottomNavigationBar: isNavigationScreen()
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: 'Calendário',
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_circle_down),
                    label: 'Devolução',
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_circle_up),
                    label: 'Entrega',
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: const Color.fromARGB(255, 254, 204, 22),
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.black,
                onTap: _onItemTapped,
              )
            : null,
      ),
    );
  }
}
