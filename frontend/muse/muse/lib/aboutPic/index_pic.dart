import 'package:muse/aboutPic/models/tabIcon_data.dart';

import 'package:flutter/material.dart';
import 'package:muse/aboutPic/bottom_navigation_view/bottom_bar_view.dart';
import 'package:muse/aboutPic/obj_identify/obj_identify_screen.dart';

import 'package:muse/theme/pic_app_theme.dart';
import 'package:muse/aboutPic/facing/facing_identify.dart';
import 'package:muse/aboutPic/random_pic/random_pic.dart';
import 'package:muse/show/navigation.dart';

import 'color_picker_pic/color_pick_page.dart';


class IndexPic extends StatefulWidget {
  final int page;

  const IndexPic({Key? key, required this.page}) : super(key: key);
  @override
  _IndexPicState createState() => _IndexPicState();
}

class _IndexPicState extends State<IndexPic>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: PicAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[widget.page].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    List l =[
      FacingIdentify(animationController: animationController),
      ObjIdentifyScreen(animationController: animationController),
      ColorPickPage(title: 'hh',),
      RandomPic()
    ];
    tabBody = l[widget.page];
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PicAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NavigationHomeScreen(),
                ));
            print('add');
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      FacingIdentify(animationController: animationController);

                  // ColorPickPage(title: 'hh',);
                });
              });
            }
            else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ObjIdentifyScreen(animationController: animationController);

                      // ColorPickPage(title: 'hh',);
                });
              });
            }
            else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      // ColorPickScreen(animationController: animationController);
                  ColorPickPage(title: 'hh',);
                });
              });
            }
            else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      RandomPic();
                      // FacingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
