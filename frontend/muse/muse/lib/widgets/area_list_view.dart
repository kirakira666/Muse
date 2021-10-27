import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muse/aboutPic/index_pic.dart';

import 'package:muse/theme/pic_app_theme.dart';

class AreaListView extends StatefulWidget {
  const AreaListView(
      {Key? key, required this.mainScreenAnimationController, required this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;
  @override
  _AreaListViewState createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  List<String> areaListData = <String>[
    'assets/image/tab_1s.png',
    'assets/image/tab_2s.png',
    'assets/image/tab_3s.png',
    'assets/image/tab_4s.png',
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: areaBuilder,
    );
  }

  Widget areaBuilder(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: widget.mainScreenAnimation,
      child: Transform(
        transform: Matrix4.translationValues(
            0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: GridView(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                areaListData.length,
                    (int index) {
                  final int count = areaListData.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return AreaView(
                    imagepath: areaListData[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24.0,
                crossAxisSpacing: 24.0,
                childAspectRatio: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key? key,
    this.imagepath,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final String? imagepath;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: hhhBUilder,
    );
  }

  Widget hhhBUilder(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform: Matrix4.translationValues(
            0.0, 50 * (1.0 - animation.value), 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: PicAppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: PicAppTheme.grey.withOpacity(0.4),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              splashColor: PicAppTheme.nearlyDarkBlue.withOpacity(0.2),
              onTap: () {
                if(imagepath=='assets/image/tab_1s.png'){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => IndexPic(page: 0,),
                      ));
                }else if(imagepath=='assets/image/tab_2s.png'){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => IndexPic(page: 1,),
                      ));
                }else if(imagepath=='assets/image/tab_3s.png'){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => IndexPic(page: 2,),
                      ));
                }else if(imagepath=='assets/image/tab_4s.png'){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => IndexPic(page: 3,),
                      ));
                }
                print('g');
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Image.asset(imagepath!),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AnimationController?>('animationController', animationController));
  }
}
