import 'package:flutter/material.dart';
import 'package:muse/theme/pic_app_theme.dart';

class FindMoreView extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> animation;

  const FindMoreView({Key? key, required this.animationController, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: hhbuilder,
    );
  }

  Widget hhbuilder(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: animation,
      child: new Transform(
        transform: new Matrix4.translationValues(
            0.0, 30 * (1.0 - animation.value), 0.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 0, bottom: 0),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: PicAppTheme.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: PicAppTheme.grey.withOpacity(0.4),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                            child: SizedBox(
                              height: 74,
                              child: AspectRatio(
                                aspectRatio: 1.714,
                                child: Image.asset(
                                    "assets/image/back.png"),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 16,
                                      top: 16,
                                      bottom: 4
                                    ),
                                    child: Text(
                                      "Find more inspiration in Muse!",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                        PicAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color:
                                        PicAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  bottom: 12,
                                  top: 4,
                                  right: 16,
                                ),
                                child: Text(
                                  "Inspire your creative ideas!",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: PicAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    letterSpacing: 0.0,
                                    color: PicAppTheme.grey
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 0,
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Image.asset("assets/image/zjb2.png"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
