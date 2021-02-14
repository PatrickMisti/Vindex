import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vindex/db/database/DatabaseExtension.dart';
import 'package:vindex/db/enitiy/review.dart';
import 'package:vindex/utilities/colorpalettes.dart';
import 'package:icon_shadow/icon_shadow.dart';

class ReviewScreen extends StatefulWidget {
  final int _wineId;

  ReviewScreen(this._wineId);

  @override
  _ReviewScreen createState() => _ReviewScreen();
}

class _ReviewScreen extends State<ReviewScreen> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _animation;
  double _minHeightIsShow = 100;
  double _maxHeightIsShow = 0.9;
  var panelState = PanelState.CLOSED;
  bool isEditing = false;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1), vsync: this);
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);

  }

  calcReviewAverage(List<Review> reviews){
    int count = 0;
    for(var item in reviews) {
      count += item.getRating;
    }
    return (count / reviews.length).toStringAsFixed(1);
  }

  addReview() async {
    var date = DateTime.now().toIso8601String().split('T');
    Review review = new Review(null, date[0].toString(), 0, "", "", widget._wineId);
    setState(() async {
      await DatabaseExtension.insert(review);
    });
  }

  Widget iconReviewShow(Review review) {
    if(isEditing) {
      return GestureDetector(
        onTap: () {
          showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
            title: Text("Do you really want to delete this review"),
            actions: [
              CupertinoDialogAction(child: Text("No"),onPressed: () => Navigator.pop(context),),
              CupertinoDialogAction(child: Text("Yes"),onPressed: () {
                setState(() {
                  DatabaseExtension.delete(review);
                });
                Navigator.pop(context);
              },)
            ],
          ),
          );
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.close_menu,
          progress: _animation,
          color: ColorPalette.red,
        ),
      );
    }
    return SizedBox(width: 0,);
  }

  Widget _headerSlidingUpPanel(snapshot, size) {
    return Container(
      height: 110,
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Container(
                  width: size.width * 0.333,
                  child: Center(
                      child: Text(
                        "Edit",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ),
              ),
              Container(
                  width: size.width * 0.333,
                  child: Center(
                      child: IconShadowWidget(Icon(
                        Icons.remove,
                        size: 50,
                        color: Colors.grey,
                      )))),
              GestureDetector(
                onTap: () {
                  addReview();
                },
                child: Container(
                  width: size.width * 0.333,
                  child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ),
              )
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text("Count Review: ${snapshot.data.length}"),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text("Durchschnitt.: ${calcReviewAverage(snapshot.data)} / 100"),
                  ))
            ],
          ),
          SizedBox(height: 7),
          Divider(
            color: ColorPalette.black,
            thickness: 2,
          )
        ],
      ),
    );
  }

  Widget _panelSlidingUpPanel(snapshot, size) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: snapshot.hasData
          ? ListView.builder(
        itemCount: snapshot.data.length,
        reverse: true,
        itemBuilder: (context, index) {
          if (snapshot.data.length == 0 || snapshot.data == null) {
            return Center(
              child: Text("No Data"),
            );
          } else {
            Review review = snapshot.data[index];
            DateTime datetime = DateTime.parse(review.getRatingDate.toString());

            return Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                                "${datetime.day}-${datetime.month}-${datetime.year}"),
                          )),
                      Spacer(flex: 1),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: isEditing
                                ? Row(children: [
                              Expanded(
                                child: CupertinoTextField(
                                  maxLength: 3,
                                  controller: TextEditingController(text: review.getRating.toString()),
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    review.setRating = int.parse(value);
                                    DatabaseExtension.update(review);
                                  },
                                ),
                              ),
                              Expanded(child: Text("/100"))
                            ],)
                                : Text(
                                "${review.getRating.toString()} / 100"),
                          ))
                    ],
                  ),


                  Container(
                      height: 100,
                      width: size.width,
                      margin: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: <Widget>[
                          iconReviewShow(review),
                          Spacer(flex: 1,),
                          Expanded(
                            flex: 20,
                            child: CupertinoTextField(
                              maxLines: 6,
                              enabled: isEditing,
                              controller: TextEditingController(text: review.getStringRating),
                              onChanged: (value) {
                                review.setStringRating = value;
                                DatabaseExtension.update(review);
                              },
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorPalette.black,width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),

                        ],
                      )
                  ),

                  Divider(color: ColorPalette.black,)
                ],

              ),
            );
          }

        },
      )
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      //todo review view only work here to do
      initialData: new List<Review>(),
      future: DatabaseExtension.getReviewsFromWineId(widget._wineId),
      builder: (context, snapshot) {
        return SlidingUpPanel(
          backdropEnabled: true,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          parallaxEnabled: true,
          backdropTapClosesPanel: true,
          minHeight: _minHeightIsShow,
          maxHeight: size.height * _maxHeightIsShow,
          header: _headerSlidingUpPanel(snapshot, size),
          defaultPanelState: panelState,
          panel: _panelSlidingUpPanel(snapshot, size),
        );
      },
    );
  }
}
