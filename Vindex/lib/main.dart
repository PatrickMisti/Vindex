import 'package:flutter/material.dart';
import 'package:vindex/overview.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/': (context) => Overview()
      },
    );
  }
}
