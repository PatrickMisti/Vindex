import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vindex/db/database/DatabaseExtension.dart';
import 'package:vindex/db/enitiy/wine.dart';
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

  bool editing = false;
  Color editingColor = ColorPalette.black;
  var navBarName = [
    {1, "Edit"},
    {2, "Cancel"},
    {3, "Delete"}
  ];

  CupertinoSliverNavigationBar appBarSliver() {
    var navBarSelection = navBarName[0].toList();
    return CupertinoSliverNavigationBar(
      backgroundColor: ColorPalette.red.withOpacity(0.5),
      largeTitle: Container(
        //nav_bar.dart apk change height const double _kNavBarLargeTitleHeightExtension = 90.0;
        child: Column(
          children: [
            Text("Vindex"),
            // done 932 row nav_bar.dart from middle to Text("Vindex")
            new IOSSearchBar(
              animation: _animation,
              controller: _searchTextController,
              focusNode: _searchFocusNode,
              onCancel: _cancelSearch,
              onClear: _clearSearch,
            ),
          ],
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            editing = !editing;
            editingColor = editingColor == ColorPalette.black
                ? Colors.blue
                : ColorPalette.black;
          });
        },
        child: Container(
          child: Text(navBarSelection[1].toString(),
              style: TextStyle(
                  color: editingColor,
                  decoration: TextDecoration.underline)),
        ),
      ),
    );
  }

  FutureBuilder sliverBody() {
    bool isSelected = false;
    var isSelectedIcon = Icons.check_circle_outline;
    return FutureBuilder(
      future: DatabaseExtension.getAll<Wine>(),
      builder: (context, snapshot) {
        return SliverGrid(
            delegate: SliverChildListDelegate(snapshot.hasData
                ? List<Widget>.generate(snapshot.data.length, (idx) {
              return Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: GestureDetector(
                      onTap: () {
                        print("wine push from homescreen");
                        Navigator.pushNamed(context, '/wine',arguments: snapshot.data[idx]);
                      },
                      child: Container(
                        child: Image.memory(snapshot.data[idx].getPicture),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 0,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                            isSelectedIcon = isSelected == false
                                ? Icons.check_circle_outline
                                : Icons.check_circle;
                          });
                        },
                        child: Icon(
                          isSelectedIcon,
                          color: ColorPalette.black,
                        )),
                  )
                ],
              );
            })
                : [CupertinoActivityIndicator()]),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 0.6)
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
        child: CustomScrollView(
            shrinkWrap: false,
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              appBarSliver(),
              sliverBody()
            ]
        )
    );
  }
}



