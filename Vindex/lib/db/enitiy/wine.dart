import 'dart:typed_data';
import 'package:floor/floor.dart';

@Entity(tableName: 'wine')
class Wine {
  @PrimaryKey(autoGenerate: true)
  final int id;
  String name;
  int vintage;
  Uint8List picture;
  String location;
  
  Wine(this.id, this.name, this.vintage, this.picture, this.location);

  Wine.inputs(this.id, {setName, setVintage, setPicture, setLocation});

  String get getLocation => location;

  set setLocation(String value) {
    location = value;
  }

  Uint8List get getPicture => picture;

  set setPicture(Uint8List value) {
    picture = value;
  }

  int get getVintage => vintage;

  set setVintage(int value) {
    vintage = value;
  }

  String get getName => name;

  set setName(String value) {
    name = value;
  }
}