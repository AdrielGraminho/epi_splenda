import 'package:flutter/material.dart';
import 'package:splenda_epi/screens/audit_screen.dart';
import 'package:splenda_epi/screens/ppra_pcmso_screen.dart';

import '../../screens/calendar_screen.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final bool? navigation;
  const BaseScreen({Key? key, required this.child, this.navigation})
      : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    int _selectedIndex = 0;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      Text(
        'Index 3: Settings',
        style: optionStyle,
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    bool isNavigationScreen() {
      if (widget.navigation == true) {
        return true;
      } else {
        return false;
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
        appBar: isNavigationScreen()
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
                      title: const Text('Auditoria'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuditScreen()),
                      ),
                    ),
                    ListTile(
                      title: const Text('PPRA e PCMSO'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PpraPcmsoScreen()),
                      ),
                    ),
                    ListTile(
                      title: const Text('Conta'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
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
