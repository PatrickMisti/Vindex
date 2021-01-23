
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 220,
          title: TextField(
            
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset('assets/wine.jpg',fit: BoxFit.fitWidth,),
          ),
        )
      ],
    );
  }
}