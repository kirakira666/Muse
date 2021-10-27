import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/widgets/area_list_view.dart';
import 'package:muse/widgets/find_more_view.dart';
import 'package:muse/widgets/title_view.dart';
import 'package:muse/widgets/single_idea_view.dart';
import 'package:flutter/material.dart';
import 'package:muse/show/welcome_page.dart';
import 'package:muse/show/share_idea.dart';
import 'package:muse/utils/cloud_utils.dart';
import 'package:smart_flare/smart_flare.dart';

import 'package:muse/utils/storage_util.dart';
import 'package:muse/theme/pic_app_theme.dart';
List ideaList = [];
CloudBaseCore core = CloudBaseCore.init({
  // 填写您的云开发 env
  'env': cloudInfo.env,
  // 填写您的移动应用安全来源凭证
  // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
  'appAccess': {
    // 凭证
    'key': cloudInfo.accessKey,
    // 版本
    'version': cloudInfo.accessVersion
  },
  // 请求超时时间（选填）
  'timeout': 3000
});
CloudBaseAuth auth = CloudBaseAuth(core);
CloudBaseDatabase db = CloudBaseDatabase(core);

class IdeaListScreen extends StatefulWidget {
  const IdeaListScreen({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _IdeaListScreenState createState() => _IdeaListScreenState();
}

class _IdeaListScreenState extends State<IdeaListScreen>
    with TickerProviderStateMixin {
  late Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    addListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {

        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        // addListData();
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  Future<void> addListData() async {
    CloudBaseAuthState authState = await auth.getAuthState();
    print('jnkfj');
    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('注册成功');
      }).catchError((err) {
        // 登录失败
        print('注册失败');
      });
    }
    db.collection('idea').where({
    }).get().then((res) {
      print(res.data);
      ideaList = res.data;
      for (int i = 0; i < ideaList.length; ++i) {
        String content = ideaList[ideaList.length - i - 1]['content'];
        String username = ideaList[ideaList.length - i - 1]['popname'];
        String picUrl = 'empty';
        print(ideaList[ideaList.length - i - 1]['popname']);
        var ideaItem = ideaList[ideaList.length - i - 1];
        if(ideaList[ideaList.length - i - 1]['url'] == null||ideaList[ideaList.length - i - 1]['url'].length == 0){
          picUrl = 'empty';
        }else{
          picUrl = ideaList[ideaList.length - i - 1]['url'][0];
          if(picUrl==''){
            picUrl = 'empty';
          }
        }

        print(ideaList[ideaList.length - i - 1]['url']);

        listViews.add(
          SingleIdeaView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve:
                    Interval((1 / 5) * 2, 1.0, curve: Curves.fastOutSlowIn))),
            animationController: widget.animationController,
            nameJJ: content,
            username: username, picUrl: picUrl, urlList: ideaItem['url'], like: ideaItem['like'], id: ideaItem['_id'],
          ),
        );
      }
    });
  }

  Future<void> addAllListData() async {
    const int count = 5;

    listViews.add(
        SizedBox(
          height: 250,
        )
    );

    listViews.add(
      FindMoreView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Scroll down to explore!',
        subTxt: 'more',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    // listViews.add(
    //   AreaListView(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //             parent: widget.animationController,
    //             curve: Interval((1 / count) * 5, 1.0,
    //                 curve: Curves.fastOutSlowIn))),
    //     mainScreenAnimationController: widget.animationController,
    //   ),
    // );
  }

  Future<void> addAllListData1() async {
    const int count = 5;

    listViews.add(
      AreaListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 5, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
    // listViews.add(
    //   WorkoutView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController,
    //         curve:
    //         Interval((1 / 5) * 2, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController, nameJJ: 'content', username: 'ii',
    //   ),
    // );
  }

  Future<bool> getData() async {
    // addAllListData();
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Future<void> _jumpDetailPage() async {
    String token =
    await StorageUtil.getStringItem('username');
    if (token != null) {
      // 跳转到showIdea
      print('yijdl');
      Fluttertoast.showToast(
          msg: "已经登录！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ShareIdea(),
          ));
    } else {
      Fluttertoast.showToast(
          msg: "请先登录！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
      // 跳转到登陆页面
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => WelcomePage(),
          ));
    }

  }
  Future<void> _jumpLoginPage() async {
    String token =
    await StorageUtil.getStringItem('username');
    if (token != null) {
      // 跳转到首页
      print('yijdl');
      Fluttertoast.showToast(
          msg: "已经登录！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
    } else {
      // 跳转到登陆页面
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => WelcomePage(),
          ));
    }

  }
  Future<void> _logout() async {
    String token =
    await StorageUtil.getStringItem('username');
    if (token != null) {
      // 跳转到首页
      print('yijdl');
      StorageUtil.remove('username');
      StorageUtil.remove('pwd');
      Fluttertoast.showToast(
          msg: "退出登录！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "当前处于未登陆状态！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    addAllListData1();
    addListData();
    var animationWidth = 295.0;
    var animationHeight = 251.0;
    var animationWidthThirds = animationWidth / 3;
    var halfAnimationHeight = animationHeight / 2;

    var activeAreas = [
      ActiveArea(
          area: Rect.fromLTWH(0, 0, animationWidthThirds, halfAnimationHeight),
          debugArea: false,
          guardComingFrom: ['deactivate'],
          animationName: 'camera_tapped',
          onAreaTapped: () {
            print('Detail tapped!');
            _jumpDetailPage();
          }),
      ActiveArea(
          area: Rect.fromLTWH(animationWidthThirds, 0, animationWidthThirds,
              halfAnimationHeight),
          debugArea: false,
          guardComingFrom: ['deactivate'],
          animationName: 'camera_tapped',
          onAreaTapped: () {
            print('Login tapped!');
            _jumpLoginPage();
          }),
      ActiveArea(
          area: Rect.fromLTWH(animationWidthThirds * 2, 0, animationWidthThirds,
              halfAnimationHeight),
          debugArea: false,
          guardComingFrom: ['deactivate'],
          animationName: 'image_tapped',
          onAreaTapped: () {
            print('log out!');
            _logout();
          }),
      ActiveArea(
          area: Rect.fromLTWH(
              0, animationHeight / 2, animationWidth, animationHeight / 2),
          debugArea: false,
          animationsToCycle: ['activate', 'deactivate'],
          onAreaTapped: () {
            print('Button tapped!');
          })
    ];
    return Container(
      color: PicAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getAppBarUI(),
            getAppBarm(),
            getMainListViewUI(),
            getAppBarUIUp(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SmartFlareActor(
                width: animationWidth,
                height: animationHeight,
                filename: 'assets/image/button-animation.flr',
                startingAnimation: 'deactivate',
                activeAreas: activeAreas,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: hhbuilder,
        )
      ],
    );
  }

  Widget getAppBarm() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: mbuilder,
        )
      ],
    );
  }

  Widget getAppBarUIUp() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: hhbuilderUp,
        )
      ],
    );
  }

  Widget mbuilder(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: topBarAnimation,
      child: Transform(
        transform: Matrix4.translationValues(
            0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
        child: Container(
          // height:100,
          decoration: BoxDecoration(
            color: PicAppTheme.white.withOpacity(topBarOpacity),
            borderRadius: const BorderRadius.only(
              // bottomLeft: Radius.circular(32.0),
              // bottomRight: Radius.circular(32.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: PicAppTheme.grey
                      .withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                child: _rootBack(),
              ),
              Positioned(
                top: 20,
                  child: scrollController.offset <= 20?Image.asset(
                    'assets/image/1.gif',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ):SizedBox(height: 1,),
              ),

              Image.asset(
                'assets/image/mon.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
          // Column(
          //   children: <Widget>[
          //
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget hhbuilder(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: topBarAnimation,
      child: Transform(
        transform: Matrix4.translationValues(
            0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
        child: Container(
          // height:100,
          decoration: BoxDecoration(
            color: PicAppTheme.white.withOpacity(topBarOpacity),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: PicAppTheme.grey
                      .withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Stack(
            children: [

              SizedBox(
                height: MediaQuery.of(context).padding.top,

              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * topBarOpacity*2,
                    bottom: 12 - 8.0 * topBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'jj',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: PicAppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * topBarOpacity,
                            letterSpacing: 1.2,
                            color: PicAppTheme.darkerText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(32.0)),
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: PicAppTheme.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.calendar_today,
                              color: PicAppTheme.grey,
                              size: 18,
                            ),
                          ),
                          Text(
                            '15 May',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: PicAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              letterSpacing: -0.2,
                              color: PicAppTheme.darkerText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 99,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(32.0)),
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: PicAppTheme.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          // Column(
          //   children: <Widget>[
          //
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget hhbuilderUp(BuildContext context, Widget? child) {
    return FadeTransition(
      opacity: topBarAnimation,
      child: Transform(
        transform: Matrix4.translationValues(
            0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: PicAppTheme.white.withOpacity(topBarOpacity),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: PicAppTheme.grey
                      .withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * topBarOpacity,
                    bottom: 12 - 8.0 * topBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: PicAppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * topBarOpacity,
                            letterSpacing: 1.2,
                            color: PicAppTheme.darkerText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 38,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(32.0)),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.lightbulb,
                              color: PicAppTheme.grey,
                              size: 21,
                            ),
                          ),
                          Text(
                            'Share your Ideas!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: PicAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              letterSpacing: -0.2,
                              color: PicAppTheme.darkerText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 0,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(32.0)),
                        onTap: () {},
                        // child: Center(
                        //   child: Icon(
                        //     Icons.keyboard_arrow_right,
                        //     color: PicAppTheme.grey,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _rootBack() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
        color: Colors.black,
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/image/star.GIF',
            fit: BoxFit.cover,
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )
        ],
      ),
    );
  }

}

