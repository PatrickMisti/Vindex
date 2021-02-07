import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vindex/utilities/wineSelectedIcon.dart';

extension WineSelectedIconExtension on WineSelectedIcon {
  getIcon(){
    var black = Colors.black;
    return this == WineSelectedIcon.checked ? Icon(Icons.check_circle,color: black,) :Icon(Icons.check_circle_outline,color: black,);
  }
}