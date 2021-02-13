import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vindex/navigationBarItem/setting/settingChoseView.dart';
import 'package:vindex/utilities/colorpalettes.dart';
import 'package:vindex/utilities/settingEnum.dart';

class SettingConverter extends StatefulWidget {
  final IconData _icon;
  final String _text;
  final SettingEnum settingChoose;

  SettingConverter(this._icon, this._text, this.settingChoose);

  @override
  _SettingConverter createState() => _SettingConverter();
}

class _SettingConverter extends State<SettingConverter> {

  showTransition() {
    Navigator.push(
        context,
        CupertinoPageRoute(
            fullscreenDialog: false,
            builder: (context) => SettingChoseView(widget.settingChoose)));
  }

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Container(
      height: sizes.height * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 20,),
      child: GestureDetector(
        onTap: () => this.showTransition(),
        child: Row(
          children: [
            Icon(widget._icon,color: ColorPalette.red, size: 25),
            SizedBox(width: 30,),
            Text(widget._text, style: TextStyle(fontSize: 20)),
            Spacer(flex: 2),
            Icon(Icons.arrow_forward_ios, size: 25)
          ],
        ),
      ),
    );
  }
}
