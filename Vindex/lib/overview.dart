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
  CupertinoTabController _controller = new CupertinoTabController();

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBuilder: (context, index) {
        return _widgetOptions.elementAt(index);
      },
      tabBar: CupertinoTabBar(
        backgroundColor: ColorPalette.red.withOpacity(0.7),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_outlined,size: 33,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              activeIcon: Icon(Icons.add,size: 33,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings_applications_outlined,size: 33,))
        ],
        currentIndex: _controller.index,
        onTap: (index) {
          setState(() {
            _controller.index = index;
          });
        },
        activeColor: Colors.blueGrey,
        inactiveColor: ColorPalette.red,
      ),
    );
  }
}
