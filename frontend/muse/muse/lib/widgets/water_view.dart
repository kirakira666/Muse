import 'package:muse/widgets/glass_view.dart';
import 'package:muse/widgets/wave_view.dart';
import 'package:muse/theme/pic_app_theme.dart';
import 'package:flutter/material.dart';
double vv = 0.0;
class WaterView extends StatefulWidget {
  const WaterView(
      {Key? key, required this.mainScreenAnimationController, required this.mainScreenAnimation, required this.valuePer})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;
  final double valuePer;
  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  // Future<bool> getData() async {
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 50));
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: hhbuilder(context,),
    );
    //   AnimatedBuilder(
    //   animation: widget.mainScreenAnimationController,
    //   builder: hhbuilder,
    // );
  }

  Widget hhbuilder(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
          0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: PicAppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: PicAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 16, left: 16, right: 16, bottom: 16),
            child: Row(

              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, bottom: 3),
                                child: Text(
                                  hhtext(widget.valuePer),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: PicAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32,
                                    color: PicAppTheme.nearlyDarkBlue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 8),
                                child: Text(
                                  '%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: PicAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: -0.2,
                                    color: PicAppTheme.nearlyDarkBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, top: 2, bottom: 14),
                            child: Text(
                              'of similarity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: PicAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: PicAppTheme.darkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 8, bottom: 16),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: PicAppTheme.background,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(4.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 4),
                                //   child: Icon(
                                //     Icons.face_retouching_natural,
                                //     color: PicAppTheme.grey
                                //         .withOpacity(0.5),
                                //     size: 16,
                                //   ),
                                // ),
                                SizedBox(width: 20,),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Find more about',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily:
                                      PicAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: PicAppTheme.grey
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'your face in artworks！',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily:
                                  PicAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  color: PicAppTheme.grey
                                      .withOpacity(0.5),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 4),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //     MainAxisAlignment.start,
                            //     crossAxisAlignment:
                            //     CrossAxisAlignment.center,
                            //     children: <Widget>[
                            //       // SizedBox(
                            //       //   width: 24,
                            //       //   height: 24,
                            //       //   child: Image.asset(
                            //       //       'assets/fitness_app/bell.png'),
                            //       // ),
                            //       Flexible(
                            //         child: Text(
                            //           'your face in artworks!',
                            //           textAlign: TextAlign.start,
                            //           style: TextStyle(
                            //             fontFamily:
                            //             PicAppTheme.fontName,
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 12,
                            //             letterSpacing: 0.0,
                            //             color: HexColor('#F65283'),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // CardScrollWidget(0),
                SizedBox(
                  width: 34,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: PicAppTheme.nearlyWhite,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: PicAppTheme.nearlyDarkBlue
                                    .withOpacity(0.4),
                                offset: const Offset(4.0, 4.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.add,
                            color: PicAppTheme.nearlyDarkBlue,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: PicAppTheme.nearlyWhite,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: PicAppTheme.nearlyDarkBlue
                                    .withOpacity(0.4),
                                offset: const Offset(4.0, 4.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.remove,
                            color: PicAppTheme.nearlyDarkBlue,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16, right: 8, top: 16),
                  child: Container(
                    width: 60,
                    height: 160,
                    decoration: BoxDecoration(
                      color: HexColor('#E8EDFE'),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(80.0),
                          bottomLeft: Radius.circular(80.0),
                          bottomRight: Radius.circular(80.0),
                          topRight: Radius.circular(80.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: PicAppTheme.grey.withOpacity(0.4),
                            offset: const Offset(2, 2),
                            blurRadius: 4),
                      ],
                    ),
                    child: WaveView(
                      percentageValue: widget.valuePer,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String hhtext(double valuePer) {
      return valuePer.toString()[0]+valuePer.toString()[1]+valuePer.toString()[2]+valuePer.toString()[3];
  }
}

