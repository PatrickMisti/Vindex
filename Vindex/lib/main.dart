import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vindex/navigationBarItem/setting/settingChoseView.dart';
import 'package:vindex/overview.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Overview(),
      },
    );
  }
}
