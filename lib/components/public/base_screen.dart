import 'package:flutter/material.dart';

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
                selectedItemColor: Colors.amber[800],
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.black,
                onTap: _onItemTapped,
              )
            : null,
      ),
    );
  }
}
