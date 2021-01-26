import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vindex/overview.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Overview(),
      },
    );
  }
}
