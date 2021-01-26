import 'dart:async';
import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:vindex/db/database/dao.dart';
import 'package:vindex/db/enitiy/review.dart';
import 'package:vindex/db/enitiy/wine.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'appDatabase.g.dart';

@Database(version: 1, entities: [Wine, Review])
abstract class AppDatabase extends FloorDatabase {
  WineDao get wineDao;
  ReviewDao get reviewDao;
}