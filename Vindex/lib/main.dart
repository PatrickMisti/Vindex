import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vindex/db/database/DatabaseExtension.dart';
import 'package:vindex/navigationBarItem/wineDetail.dart';
import 'package:vindex/overview.dart';

void main() async {
  await DatabaseExtension.init();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Overview(),
      },
      onGenerateRoute: (setting){
        if (setting.name == '/wine')
          return CupertinoPageRoute(
            fullscreenDialog: false,
            builder: (context) => WineDetail(setting.arguments)
          );
        return null;
      },
    );
  }
}
