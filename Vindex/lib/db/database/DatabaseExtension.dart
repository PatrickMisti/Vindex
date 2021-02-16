import 'package:vindex/db/database/appDatabase.dart';
import 'package:vindex/db/enitiy/review.dart';
import 'package:vindex/db/enitiy/wine.dart';

class DatabaseExtension {
  static AppDatabase _db;

  static init() async {
    //_db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    _db = await $FloorAppDatabase.databaseBuilder('vindex.db').build();
  }

  static Future<List> getAll<T>() async {
    if (T == Wine)
      return await _db.wineDao.findAllWineFuture();
    if (T == Review)
      return await _db.reviewDao.findAllReviewFuture();
    else
      return null;
  }

  static Stream<List> getAllStream<T>() {
    if (T == Wine)
      return _db.wineDao.findAllWineStream();
    if (T == Review)
      return _db.reviewDao.findAllReviewStream();
    else
      return null;
  }

  static Future<dynamic> findById<T> (int entityId) async {
    if (T == Wine)
      return await _db.wineDao.findWineById(entityId);
    if (T == Review)
      return await _db.reviewDao.findReviewById(entityId);
    else
      return null;
  }

  static Future<int> insert<T> (T entity) async {
    if (entity is Wine)
      return _db.wineDao.insertWine(entity);
    if (entity is Review)
      return _db.reviewDao.insertReview(entity);
    else
      return -1;
  }

  static Future<int> update<T> (T entity) async {
    if (entity is Wine)
      return _db.wineDao.updateWine(entity);
    if (entity is Review)
      return _db.reviewDao.updateReview(entity);
    else
      return -1;
  }

  static Future<void> delete<T> (T entity) async {
    if (entity is Wine) {
      _db.reviewDao.deleteReviewByWineId(entity.id);
      _db.wineDao.deleteWine(entity);
    }
    if (entity is Review)
      _db.reviewDao.deleteReview(entity);
  }

  static Future<void> deleteById<T> (int entityId) async {
    if (T == Wine){
      await _db.reviewDao.deleteReviewByWineId(entityId);
      await _db.wineDao.deleteWineById(entityId);
    }

    if (T == Review)
      await _db.reviewDao.deleteReviewById(entityId);
  }

  static Future<List<Review>> getReviewsFromWineId(int entityId) async{
    return await _db.reviewDao.findReviewByWineId(entityId);
  }
}