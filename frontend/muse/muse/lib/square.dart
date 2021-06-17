import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/storage_util.dart';
import 'package:smart_flare/actors/pan_flare_actor.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_flare/actors/smart_flare_actor.dart';
import 'package:smart_flare/enums.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_flare/models.dart';
import 'package:muse/detail.dart';
import 'package:muse/login.dart';
import 'package:muse/page/welcome_page.dart';
import 'package:image_picker/image_picker.dart';

class Square extends StatefulWidget {
  const Square({Key? key}) : super(key: key);

  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> {
  void _jumpDetailPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Detail(),
        ));
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
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "当前处于未登陆状态！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
    }
  }
  @override
  Widget build(BuildContext context) {
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
          animationName: 'pulse_tapped',
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
            'images/star.GIF',
            fit: BoxFit.cover,
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )
        ],
      ),
    );
  }

  Widget _goShow() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        decoration: new BoxDecoration(
          // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Show', style: TextStyle(color: Colors.white, fontSize: 12)),
            // Text('${_currentTime}s', style: TextStyle(color: Colors.white,fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _goFind() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        decoration: new BoxDecoration(
          // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Find', style: TextStyle(color: Colors.white, fontSize: 12)),
            // Text('${_currentTime}s', style: TextStyle(color: Colors.white,fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

//
// class _RootPageState extends State<RootPage> {
//   @override
//   Widget build(BuildContext context) {
//     var animationWidth = 295.0;
//     var animationHeight = 251.0;
//     var animationWidthThirds = animationWidth / 3;
//     var halfAnimationHeight = animationHeight / 2;
//
//     var activeAreas = [
//
//       ActiveArea(
//         area: Rect.fromLTWH(0, 0, animationWidthThirds, halfAnimationHeight),
//         debugArea: false,
//         guardComingFrom: ['deactivate'],
//         animationName: 'camera_tapped',
//       ),
//
//       ActiveArea(
//           area: Rect.fromLTWH(animationWidthThirds, 0, animationWidthThirds, halfAnimationHeight),
//           debugArea: false,
//           guardComingFrom: ['deactivate'],
//           animationName: 'pulse_tapped'),
//
//       ActiveArea(
//           area: Rect.fromLTWH(animationWidthThirds * 2, 0, animationWidthThirds, halfAnimationHeight),
//           debugArea: false,
//           guardComingFrom: ['deactivate'],
//           animationName: 'image_tapped'),
//
//       ActiveArea(
//           area: Rect.fromLTWH(0, animationHeight / 2, animationWidth, animationHeight / 2),
//           debugArea: false,
//           animationsToCycle: ['activate', 'deactivate'],
//           onAreaTapped: () {
//             print('Button tapped!');
//           })
//
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flare Button Demo'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0x3fffeb3b),
//                 Colors.orange,
//               ]),
//         ),
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: SmartFlareActor(
//             width: animationWidth,
//             height: animationHeight,
//             filename: 'images/button-animation.flr',
//             startingAnimation: 'deactivate',
//             activeAreas: activeAreas,
//           ),
//         ),
//       ),
//     );
//   }
// }
