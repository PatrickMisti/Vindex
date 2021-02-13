import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vindex/navigationBarItem/setting/settingConverter.dart';
import 'package:vindex/utilities/colorpalettes.dart';
import 'package:vindex/utilities/settingEnum.dart';

class SettingScreen extends StatelessWidget {
  final List<SettingConverter> settingList = [
    SettingConverter(Icons.delete_forever, "Reset All", SettingEnum.delete),
    SettingConverter(Icons.find_replace, "User", SettingEnum.manager)
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Settings"),
        backgroundColor: ColorPalette.red.withOpacity(0.5),
      ),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: size.height,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: settingList.length,
                itemBuilder: (context, index) {
                  return settingList[index];
                },
              ),
            ],
          )),
    );
  }
}
