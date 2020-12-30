import 'package:floor/floor.dart';
import 'package:vindex/db/enitiy/wine.dart';

@Entity(
    tableName: 'review',
    foreignKeys: [
      ForeignKey(
          childColumns: ['wine_id'],
          parentColumns: ['_id'],
          entity: Wine
      )
    ])
class Review {
  @PrimaryKey(autoGenerate: true)
  final int _id;
  final DateTime _ratingDate;
  int _rating;
  String _stringRating;
  String _wineForFood;

  @ColumnInfo(name: 'wine_id',nullable: false)
  final int _wineId;

  Review(this._id, this._ratingDate, this._rating, this._stringRating,
      this._wineForFood, this._wineId);

  Review.constructor(this._id, this._ratingDate, this._wineId, {setRating, setStringRating,
      setWineForFood});

  String get getWineForFood => _wineForFood;

  set setWineForFood(String value) {
    _wineForFood = value;
  }

  String get getStringRating => _stringRating;

  set setStringRating(String value) {
    _stringRating = value;
  }

  int get getRating => _rating;

  set setRating(int value) {
    _rating = value;
  }

  DateTime get getRatingDate => _ratingDate;

  int get getId => _id;

}