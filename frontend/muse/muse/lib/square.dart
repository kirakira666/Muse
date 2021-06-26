import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/custom_drawer/home_drawer.dart';
import 'package:muse/share_idea.dart';
import 'package:muse/storage_util.dart';
import 'package:smart_flare/actors/pan_flare_actor.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_flare/actors/smart_flare_actor.dart';
import 'package:smart_flare/enums.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_flare/models.dart';
import 'package:muse/detail.dart';
import 'package:muse/page/welcome_page.dart';

CloudBaseCore core = CloudBaseCore.init({
  // 填写您的云开发 env
  'env': 'zhuji-cloudbase-3g9902drd47633ab',
  // 填写您的移动应用安全来源凭证
  // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
  'appAccess': {
    // 凭证
    'key': 'e6f33326a0d40fecfc67ffc2877255bc',
    // 版本
    'version': '1'
  },
  // 请求超时时间（选填）
  'timeout': 3000
});
CloudBaseAuth auth = CloudBaseAuth(core);
CloudBaseDatabase db = CloudBaseDatabase(core);

class Square extends StatefulWidget {
  const Square({Key? key}) : super(key: key);

  @override
  _SquareState createState() => _SquareState();
}
// ignore: non_constant_identifier_names
var IdeaList = [];
class _SquareState extends State<Square> {
  late DrawerIndex drawerIndex;
  // @override
  // void initState() {
  //   drawerIndex = DrawerIndex.HOME;
  //   screenView = const MyHomePage();
  //   super.initState();
  // }
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
  Future<void> getContent() async {
    CloudBaseAuthState authState = await auth.getAuthState();
    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('注册成功');
      }).catchError((err) {
        // 登录失败
        print('注册失败');
      });
    }
    var _ = db.command;
    var re;
    db.collection('idea').where({

    }).get().then((res) {
      IdeaList = res.data;
      print(IdeaList);
    });
  }
  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          // screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          // screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          // screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          // screenView = InviteFriend();
        });
      } else {
        //do in your way......
      }
    }
  }
  Widget build(BuildContext context) {
    var animationWidth = 295.0;
    var animationHeight = 251.0;
    var animationWidthThirds = animationWidth / 3;
    var halfAnimationHeight = animationHeight / 2;
    getContent();

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
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // child: _rootBack(),
            child: Container(
              child: Text(
                'SQUARE',
                style: TextStyle(
                    color: Color.fromARGB(255, 19, 22, 64),
                    height: 4,
                    fontWeight: FontWeight.w100,
                    fontSize: 28),
              ),
            ),
          ),
          // Positioned(
          //   bottom: MediaQuery.of(context).padding.bottom + 10,
          //   left: 10,
          //   child: InkWell(
          //     child: _goShow(),
          //     onTap: () {
          //       print('show');
          //     },
          //   ),
          // ),
          // Positioned(
          //   bottom: MediaQuery.of(context).padding.bottom + 10,
          //   right: 10,
          //   child: InkWell(
          //     child: _goFind(),
          //     onTap: () {
          //       print('find');
          //     },
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: PanFlareActor(
          //     width: MediaQuery.of(context).size.width / 2.366,
          //     height: MediaQuery.of(context).size.height,
          //     filename: 'images/slideout-menu.flr',
          //     openAnimation: 'open',
          //     closeAnimation: 'close',
          //     direction: ActorAdvancingDirection.RightToLeft,
          //     threshold: 20.0,
          //     reverseOnRelease: true,
          //     completeOnThresholdReached: true,
          //     activeAreas: [
          //       RelativePanArea(
          //           area: Rect.fromLTWH(0, .7, 1.0, .3), debugArea: false),
          //     ],
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SmartFlareActor(
              width: animationWidth,
              height: animationHeight,
              filename: 'images/button-animation.flr',
              startingAnimation: 'deactivate',
              activeAreas: activeAreas,
            ),
          ),
        ],
      ),
    );
  }


}
