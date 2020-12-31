import 'package:floor/floor.dart';
import 'package:vindex/db/enitiy/wine.dart';

@Entity(
    tableName: 'review',
    foreignKeys: [
      ForeignKey(
          childColumns: ['wine_id'],
          parentColumns: ['id'],
          entity: Wine
      )
    ])
class Review {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String ratingDate;     //Iso standard
  int rating;
  String stringRating;
  String wineForFood;

  @ColumnInfo(name: 'wine_id',nullable: false)
  final int wineId;

  Review(this.id, this.ratingDate, this.rating, this.stringRating,
      this.wineForFood, this.wineId);

  //Review.inputs(this._id, DateTime time, this._wineId, {setRating, setStringRating,
    //  setWineForFood}): this._ratingDate = time.toIso8601String();

  String get getWineForFood => wineForFood;

  set setWineForFood(String value) {
    wineForFood = value;
  }

  String get getStringRating => stringRating;

  set setStringRating(String value) {
    stringRating = value;
  }

  int get getRating => rating;

  set setRating(int value) {
    rating = value;
  }

  DateTime get getRatingDate => DateTime.parse(ratingDate);

  int get getId => id;

}