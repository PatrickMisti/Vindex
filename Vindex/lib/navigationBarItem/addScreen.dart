import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vindex/db/database/DatabaseExtension.dart';
import 'package:vindex/db/enitiy/wine.dart';
import 'package:vindex/utilities/colorpalettes.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreen createState() => _AddScreen();
}

class _AddScreen extends State<AddScreen> {
  File _file;
  final picker = ImagePicker();
  List<String> yearsList =
      List.generate(80, (index) => (2020 - index).toString(), growable: true);
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _year = TextEditingController();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera
    );
    
    setState(() {
      if (pickedFile != null)
        _file = File(pickedFile.path);
      else
        print('No image selected.');
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery
    );

    setState(() {
      if (pickedFile != null)
        _file = File(pickedFile.path);
      else
        print('No image selected.');
    });
  }

  submitButton() async {
    final wine = new Wine(null, this._name.text, int.parse(this._year.text), this._file.readAsBytesSync() ?? null, this._location.text);
    await DatabaseExtension.insert<Wine>(wine);

    setState(() {
      this._file = null;
      this._location.text = '';
      this._year.text = '';
      this._name.text = '';
    });

    Navigator.pushNamed(context, '/wine',arguments: wine);
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
        child: _file == null
            ? Center(child: Icon(Icons.photo_camera, size: 30))
            : Image.file(_file),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: CupertinoColors.black,
        ),
      ),
      onTap: () => showImageChoose(),
    );
  }

  chooseDatePicker() {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
            height: 200,
            child: CupertinoPicker.builder(
              backgroundColor: Colors.white,
              itemExtent: 35,
              useMagnifier: true,
              onSelectedItemChanged: (dateTime) {
                setState(() {
                  _year.text = yearsList[dateTime];
                });
              },
              childCount: yearsList.length,
              itemBuilder: (context, index) {
                return Text(yearsList[index]);
              },
            )));
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
                          controller: _year,
                          placeholderStyle: TextStyle(
                              decoration: TextDecoration.underline,
                              color: ColorPalette.orange.withOpacity(0.5)),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorPalette.red.withOpacity(0.5)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          keyboardType: TextInputType.number,
                        )),
                    Center(
                      child: CupertinoButton(
                          minSize: 10,
                          padding: EdgeInsets.all(5),
                          color: ColorPalette.red,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          child: Icon(Icons.extension, size: 23),
                          onPressed: () => chooseDatePicker()),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: size.height *0.3,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: size.width - 40,
              child: CupertinoButton(
                color: ColorPalette.red,
                child: Text("Save"),
                onPressed: () {
                  submitButton();
                },
              ),
            ),
          ),
        ),
        /*Container(
          height: size.height * 0.43,
          child:
        )*/
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: formAbove()
        ),
      )
    );
  }
}