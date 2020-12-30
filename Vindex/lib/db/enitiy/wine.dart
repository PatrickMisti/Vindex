import 'dart:typed_data';

import 'package:floor/floor.dart';

@Entity(tableName: 'wine')
class Wine {
  @PrimaryKey(autoGenerate: true)
  final int _id;
  String _name;
  int _vintage;
  Uint8List _picture;
  String _location;

  Wine(this._id, this._name, this._vintage, this._picture, this._location);

  Wine.constructor(this._id, {setName, setVintage, setPicture, setLocation});

  String get getLocation => _location;

  set setLocation(String value) {
    _location = value;
  }

  Uint8List get getPicture => _picture;

  set setPicture(Uint8List value) {
    _picture = value;
  }

  int get getVintage => _vintage;

  set setVintage(int value) {
    _vintage = value;
  }

  String get getName => _name;

  set setName(String value) {
    _name = value;
  }
}