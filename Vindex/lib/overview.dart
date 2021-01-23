import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vindex/navigationBarItem/addScreen.dart';
import 'package:vindex/navigationBarItem/homeScreen.dart';
import 'package:vindex/navigationBarItem/settingScreen.dart';
import 'package:vindex/utilities/colorpalettes.dart';

class Overview extends StatefulWidget {
  @override
  _Overview createState() => _Overview();
}

class _Overview extends State<Overview> {
  int _selectedItemBottom = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItemBottom = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.yellow,
      body: _widgetOptions.elementAt(_selectedItemBottom),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(45)),
          child: CupertinoTabBar(
            backgroundColor: ColorPalette.red,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  activeIcon: Icon(Icons.home_outlined)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle),
                  activeIcon: Icon(Icons.add_circle_outline)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  activeIcon: Icon(Icons.settings_sharp))
            ],
            currentIndex: _selectedItemBottom,
            onTap: _onItemTapped,
            activeColor: ColorPalette.purple,
            inactiveColor: ColorPalette.orange,
          ),
        ),
      ),
    );
  }
}
