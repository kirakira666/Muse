// import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import 'package:muse/detail.dart';
import '../pic_app_theme.dart';
import 'glass_view.dart';
var context1;
class WorkoutView extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final String nameJJ;
  final String username;
  final String picUrl;
  final String id;
  final int like;
  final List urlList;

  const WorkoutView({Key? key, required this.animationController, required this.animation, required this.nameJJ, required this.username, required this.picUrl, required this.urlList, required this.like, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: hhbuilder,
    );
  }

  DecorationImage kkimage() {
    if (picUrl[0] != 'u'){
      return new DecorationImage(
        //设置背景图片
        image: AssetImage("images/star.GIF"),
        fit: BoxFit.cover,
      );
    }else{
      return new DecorationImage(
        //设置背景图片
        image:NetworkImage('https://7a68-zhuji-cloudbase-3g9902drd47633ab-1305329525.tcb.qcloud.la/'+picUrl),
        fit: BoxFit.cover,
      );
    }
  }

  Widget hhbuilder(BuildContext context, Widget? child) {
    context1 = context;
    return FadeTransition(
      opacity: animation,
      child: new Transform(
        transform: new Matrix4.translationValues(
            0.0, 30 * (1.0 - animation.value), 0.0),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 16, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
                image: kkimage(),
              gradient: LinearGradient(colors: [
                PicAppTheme.nearlyDarkBlue,
                HexColor("#6F56E8")
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: PicAppTheme.grey.withOpacity(0.6),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: PicAppTheme.fontName,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      letterSpacing: 0.0,
                      color: PicAppTheme.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      nameJJ,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: PicAppTheme.fontName,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        letterSpacing: 0.0,
                        color: PicAppTheme.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.favorite,
                            color: PicAppTheme.white,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            like.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: PicAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: PicAppTheme.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: PicAppTheme.nearlyWhite,
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: PicAppTheme.nearlyBlack
                                      .withOpacity(0.4),
                                  offset: Offset(8.0, 8.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){print('todetail');toDetail();},
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.arrow_right,
                                color: HexColor("#6F56E8"),
                                size: 44,
                              ),
                            ),
                          ),

                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toDetail() {
    Navigator.push(
        context1,
        MaterialPageRoute(
          builder: (BuildContext context) => Detail(popName: username, urlList: urlList, context: nameJJ,id:id),
        ));
  }


}
