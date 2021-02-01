import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vindex/utilities/colorpalettes.dart';
import 'package:vindex/utilities/ios_search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = new TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
  }

  void _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  GlobalKey appName = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return CupertinoPageScaffold(
        child: CustomScrollView(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: ColorPalette.red.withOpacity(0.5),
              largeTitle: Container(    //nav_bar.dart apk change height const double _kNavBarLargeTitleHeightExtension = 90.0;
                child: Column(
                  children: [
                    Text("Vindex"),// done 932 row nav_bar.dart from middle to Text("Vindex")
                    new IOSSearchBar(
                      animation: _animation,
                      controller: _searchTextController,
                      focusNode: _searchFocusNode,
                      onCancel: _cancelSearch,
                      onClear: _clearSearch,
                    ),
                  ],
                ),
              )
            ),
            SliverGrid(
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return GestureDetector(
                    onTapUp: (TapUpDetails _) {
                      _searchFocusNode.unfocus();
                      if (_searchTextController.text == '')
                        _animationController.reverse();
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.blueAccent),
                      margin: EdgeInsets.all(5),
                      child: Text("Hallo"),
                    ),
                  );
                }),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 170,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 3,
                    childAspectRatio: 0.6
                ))
          ],
        ));
  }
}