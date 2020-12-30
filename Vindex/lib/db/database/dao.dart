import 'package:floor/floor.dart';
import 'package:vindex/db/enitiy/review.dart';
import 'package:vindex/db/enitiy/wine.dart';

@dao
abstract class WineDao {
  @Query('SELECT * FROM Wine')
  Future<List<Wine>> findAllWineFuture();

  @Query('SELECT * FROM Wine')
  Stream<List<Wine>> findAllWineStream();

  @Query('SELECT * FROM Wine WHERE id = :id')
  Future<Wine> findWineById(int id);

  @insert
  Future<int> insertWine(Wine wine);

  @update
  Future<int> updateWine(Wine wine);

  @delete
  Future<int> deleteWine(Wine wine);

  @Query('SELECT * FROM Wine WHERE id = :id')
  Future<int> deleteWineById(int id);

}

@dao
abstract class ReviewDao {
  @Query('SELECT * FROM Review')
  Future<List<Review>> findAllReviewFuture();

  @Query('SELECT * FROM Review')
  Stream<List<Review>> findAllReviewStream();

  @Query('SELECT * FROM Review WHERE id = :id')
  Future<Review> findReviewById(int id);

  @insert
  Future<int> insertReview(Review review);

  @update
  Future<int> updateReview(Review review);

  @delete
  Future<int> deleteReview(Review review);

  @Query('SELECT * FROM Review WHERE id = :id')
  Future<int> deleteReviewById(int id);

}