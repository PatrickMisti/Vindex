import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vindex/db/database/DatabaseExtension.dart';
import 'package:vindex/utilities/colorpalettes.dart';

class ReviewScreen {
  double _minHeightIsShow = 80;
  double _maxHeightIsShow = .8;
  final int _wineId;

  ReviewScreen(this._wineId);

  Widget build(Size size) {
    return FutureBuilder(//todo review view only work here to do
      future: DatabaseExtension.getReviewsFromWineId(_wineId),
        builder: (context, snapshot) {
          return SlidingUpPanel(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
            parallaxEnabled: true,
            backdropTapClosesPanel: true,
            minHeight: _minHeightIsShow,
            maxHeight: size.height * _maxHeightIsShow,
            collapsed: Center(
              child: Text(""),
            ),
            panel: Center(child: Container(child: Text("Hlll"),),),
          );
        },
    );
  }
}