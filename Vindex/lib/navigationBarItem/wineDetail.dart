
import 'package:flutter/cupertino.dart';
import 'package:vindex/db/enitiy/wine.dart';

class WineDetail extends StatefulWidget {
  final Wine _wine;

  WineDetail(this._wine);

  @override
  _WineDetail createState() => _WineDetail();
}

class _WineDetail extends State<WineDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hallo"),
    );
  }

}