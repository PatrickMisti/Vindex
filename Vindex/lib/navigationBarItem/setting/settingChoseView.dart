import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vindex/utilities/colorpalettes.dart';
import 'package:vindex/utilities/settingEnum.dart';

class SettingChoseView extends StatefulWidget {
  final SettingEnum choose;

  SettingChoseView(this.choose);

  @override
  _SettingChoseView createState() => _SettingChoseView();
}

class _SettingChoseView extends State<SettingChoseView>{
  deleteAll() {
    return Container(
      child: Center(
        child: Text("Hallo",style: TextStyle(color: ColorPalette.purple)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Container view;

    switch(widget.choose) {
      case SettingEnum.delete:
        view = deleteAll();
        break;
      case SettingEnum.manager:
        view = Container(child: Text("bbb"),);
        break;
    }

    return Material(
      child: CupertinoPageScaffold(
          child: view
      ),
    );
  }

}