import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vindex/db/database/DatabaseExtension.dart';
import 'package:vindex/db/enitiy/wine.dart';
import 'package:vindex/navigationBarItem/detail/reviewScreen.dart';
import 'package:vindex/navigationBarItem/homeScreen.dart';
import 'package:vindex/utilities/colorpalettes.dart';

class WineDetail extends StatefulWidget {
  final Wine _wine;

  WineDetail(this._wine);

  @override
  _WineDetail createState() => _WineDetail();
}

class _WineDetail extends State<WineDetail> {
  File _file;
  final picker = ImagePicker();
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _year = TextEditingController();
  bool isEdit = false;
  Color editingColor;
  String editContainer = "Edit";


  @override
  void initState() {
    super.initState();
    _name.text = widget._wine.getName;
    _location.text = widget._wine.getLocation;
    _year.text = widget._wine.getVintage.toString();
  }

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera
    );

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
        widget._wine.setPicture = _file.readAsBytesSync();
      }
      else
        print('No image selected.');
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery
    );

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
        widget._wine.setPicture = _file.readAsBytesSync();
      }
      else
        print('No image selected.');
    });
  }

  updateWine() async {
    widget._wine.setLocation = this._location.text;
    widget._wine.setPicture = this._file.readAsBytesSync();
    widget._wine.setName = this._name.text;
    widget._wine.setVintage = int.parse(this._year.text);
    await DatabaseExtension.update(widget._wine);
  }

  showImageChoose() {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(
          "Choose your Option",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
              onPressed: () {
                this._imgFromGallery();
                Navigator.pop(context);
              },
              child: Text("Upload Image")),
          CupertinoActionSheetAction(
              onPressed: () {
                this._imgFromCamera();
                Navigator.pop(context);
              },
              child: Text("Take Image")),
          CupertinoActionSheetAction(
              onPressed: () {
                if (this._file != null)
                  setState(() {
                    this._file = null;
                  });
                Navigator.pop(context);
              },
              child: Text("Delete Picture"))
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  GestureDetector imageChooseContainer() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 60),
        height: 200,
        width: 150,
        child: widget._wine.getPicture == null
            ? Center(child: Icon(Icons.photo_camera, size: 30))
            : Image.memory(widget._wine.getPicture),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: CupertinoColors.black,
        ),
      ),
      onTap: () => showImageChoose(),
    );
  }

  Widget formAbove() {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            height: size.height * 0.4,
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Center(child: imageChooseContainer())),
        SizedBox(height: 20),
        Container(
          height: size.height * 0.05,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CupertinoTextField(
            controller: _name,
            style: TextStyle(fontSize: 16),
            placeholder: "Name",
            enabled: isEdit,
            placeholderStyle: TextStyle(
                decoration: TextDecoration.underline,
                color: ColorPalette.orange.withOpacity(0.5)),
            decoration: BoxDecoration(
              border:
              Border.all(color: ColorPalette.red.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: size.height * 0.05,
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: CupertinoTextField(
                  controller: _location,
                  style: TextStyle(fontSize: 16),
                  placeholder: "Location",
                  enabled: isEdit,
                  placeholderStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      color: ColorPalette.orange.withOpacity(0.5)),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorPalette.red.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Container(
                width: 120,
                child: Row(
                  children: [
                    Expanded(
                        child: CupertinoTextField(
                          style: TextStyle(fontSize: 16),
                          placeholder: "1999",
                          enabled: isEdit,
                          controller: _year,
                          placeholderStyle: TextStyle(
                              decoration: TextDecoration.underline,
                              color: ColorPalette.orange.withOpacity(0.5)),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorPalette.red.withOpacity(0.5)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              isEdit = !isEdit;
              if (isEdit) {
                editContainer = "Save";
                editingColor = Colors.blue;
              }
              else {
                editContainer = "Edit";
                editingColor = Colors.black;
                updateWine();
              }
            });
          },
          child: Text(editContainer,
              style: TextStyle(
                  color: editingColor,
                  decoration: TextDecoration.underline)),
        ),
        middle: Text("Wine Detail"),
        backgroundColor: ColorPalette.red.withOpacity(0.5),
        transitionBetweenRoutes: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: ColorPalette.black,),
        ),
      ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: formAbove()
              ),
            ),
            ReviewScreen(widget._wine.id)
          ],
        )
    );
  }
}
