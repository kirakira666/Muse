import 'dart:math';

import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
// import 'package:muse/aboutPic/color_picker_pic/color_thief_flutter.dart';
// import 'package:muse/show/widgets/login_widget.dart';
import 'package:muse/utils/cloud_utils.dart';

import 'color_pick_view.dart';

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
List random = [];
List random1 = [{
  'workName':'暂无',
  'picUrl':'https://7a68-zhuji-cloudbase-3g9902drd47633ab-1305329525.tcb.qcloud.la/src%3Dhttp___5b0988e595225.cdn.sohucs.com_images_20180523_7dd256af7f15419fb406987c7eedce99.gif%26refer%3Dhttp___5b0988e595225.cdn.sohucs.gif?sign=f5395568c4354fdab5b5948d30e9ca10&t=1625293944'
}];
var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class ColorPickPage extends StatefulWidget {
  ColorPickPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ColorPickPageState createState() => _ColorPickPageState();
}

var currentPage = random.length - 1.0;
class _ColorPickPageState extends State<ColorPickPage> {
  Color currentColor = Color(0xff0000ff);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: random.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
    List<Widget> stackChildren = [];
    // stackChildren.add(Positioned(
    //   // top: MediaQuery.of(context).padding.top,
    //   // right: (MediaQuery.of(context).size.width-300)/2,
    //   child: _homeBack(),
    // ));
    // stackChildren.add(Positioned(
    //   top: 40,
    //   child: ColorPickView(
    //     selectColor: Color(0xff0000ff),
    //     selectRadius: 600,
    //     selectRingColor: Color(0xff0000ff),
    //     size: Size(300, 300),
    //     padding: 10,
    //     selectColorCallBack: (Color color) {
    //
    //       currentColor = color;
    //       print(currentColor);
    //       return color;
    //     },
    //   ),
    // ));
    // stackChildren.add(Positioned(
    //   top: 0,
    //   child: Column(
    //     children: <Widget>[
    //       SizedBox(
    //         height: 30,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 20.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text("Colorful Arts!",
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 40.0,
    //                   fontFamily: "Calibre-Semibold",
    //                   letterSpacing: 1.0,
    //                 )),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
    // stackChildren.add(SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       SizedBox(
    //         height: 40,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 20.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text("Color for Art!",
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 40.0,
    //                   fontFamily: "Calibre-Semibold",
    //                   letterSpacing: 1.0,
    //                 )),
    //             SizedBox(
    //               height: 40,
    //               child: IconButton(
    //                 icon: Icon(
    //                   Icons.add_box,
    //                   size: 30.0,
    //                   color: Colors.black38,
    //                 ),
    //                 onPressed: () {
    //                   print('照片');
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Positioned(
    //         top: 0,
    //         child: ColorPickView(
    //           selectColor: Color(0xff0000ff),
    //           selectRadius: 600,
    //           selectRingColor: Color(0xff0000ff),
    //           size: Size(300, 300),
    //           padding: 10,
    //           selectColorCallBack: (Color color) {
    //
    //             currentColor = color;
    //             print(currentColor);
    //             return color;
    //           },
    //         ),
    //       ),
    //
    //
    //       Stack(
    //         children: <Widget>[
    //           CardScrollWidget(currentPage),
    //           Positioned.fill(
    //             child: PageView.builder(
    //               itemCount: random.length,
    //               controller: controller,
    //               reverse: true,
    //               itemBuilder: (context, index) {
    //                 return Container();
    //               },
    //             ),
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: 100,
    //       ),
    //     ],
    //   ),
    // ));
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Color for Art!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 39.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                    SizedBox(
                      height: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_box,
                          size: 30.0,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          print('照片');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
              ),


              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: random.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),

            ],
          ),
          Positioned(
            // top: 50,
            // right: MediaQuery.of(context).size.width,
            child: ColorPickView(
              selectColor: Color(0xff0000ff),
              selectRadius: 800,
              selectRingColor: Color(0xff0000ff),
              size: Size(400, 400),
              padding: 10,
              selectColorCallBack: (Color color) {

                currentColor = color;
                print(currentColor);
                return color;
              },
            ),
          ),
          // SingleChildScrollView(
          //   child: ,
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pnnn,
        tooltip: 'Pick Image',
        child: Icon(Icons.assignment_turned_in_outlined),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.endFloat, 0, -50),
    );
  }


  Future<void> pnnn() async {
    CloudBaseAuthState authState = await auth.getAuthState();

    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('注册成功');
      }).catchError((err) {
        // 登录失败
        print('注册失败');
      });
    } else {
      print('jnkfj');
    }
    var a = Random().nextInt(18744);
    var _ = db.command;
    String astr = currentColor.toString().split('0xff')[1].split(')')[0];
    var r = _hexToInt(astr[0]+astr[1]);
    var g = _hexToInt(astr[2]+astr[3]);
    var b = _hexToInt(astr[4]+astr[5]);
    db.collection('artworkColor').limit(5).where({
      'r':_.gt(r-10).and(_.lt(r+10)),

      'g':_.lt(g+10),
      'b':_.lt(b+10),
      // 'b':_.gt(b-10).and(_.lt(b+10)),
    }).get().then((res) {
      print(res);
      random = res.data;

    });
    print(currentColor.toString());
  }
  int _hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }


}
class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}
class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = [];
        print(random);
        print('random');
        if(random==null){
          random = random1;
        }
        // random = random1;
        for (var i = 0; i < random.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(random[i]['picUrl'], fit: BoxFit.cover),
                      // Image.asset(images[i], fit: BoxFit.cover),
                      // image:NetworkImage('https://7a68-zhuji-cloudbase-3g9902drd47633ab-1305329525.tcb.qcloud.la/'+picUrl),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(random[i]['workName'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(ll(5 - i),
                                    style: TextStyle(color: Colors.white)),
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
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
  // void _getPaint() {
  //   int x = Random().nextInt(18750);
  //   //数据库连接
  //   var _ = db.command;
  //   var re;
  //   db.collection('artwork').where({
  //     'index': _.eq(x)
  //   }).get().then((res) {
  //     re = res.data[0]['picUrl'];
  //     print(res.data);
  //     print(re);
  //     final imageProvider = NetworkImage(re);
  //     // 提取网络图片的主要颜色
  //     getColorFromUrl(re).then((color) {
  //       print('主要颜色');
  //       print(color); // [R,G,B]
  //       backR = color[0];
  //       backG = color[1];
  //       backB = color[2];
  //     });
  //     // 提取网络图片调色板
  //     getPaletteFromUrl(re).then((palette) {
  //       print('调色板');
  //       print(palette); // [[R,G,B]]
  //     });
  //     // 提取网络图片的实际图片
  //     getImageFromUrl(re).then((image) {
  //       print(image); // Image
  //     });
  //     // 提取 ImageProvider 的实际图片
  //     getImageFromProvider(imageProvider).then((image) {
  //       print(image); // Image
  //       // 从图片提取主要颜色
  //       getColorFromImage(image).then((color) {
  //         print('主要颜色');
  //         print(color); // [R,G,B]
  //       });
  //       // 从图片提取调色板
  //       getPaletteFromImage(image).then((palette) {
  //         print('调色板');
  //         print(palette); // [[R,G,B]]
  //       });
  //     });
  //   });
  // }
  String ll(i) {
    if (i == 1) {
      return '1st';
    } else if (i == 2) {
      return '2nd';
    } else if (i == 3) {
      return '3rd';
    }
    return i.toString() + 'th';
  }
}