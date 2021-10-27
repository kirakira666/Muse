import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/utils/cloud_utils.dart';
import 'dart:math';
import 'package:muse/show/navigation.dart';
import 'package:muse/aboutPic/color_picker_pic/color_pick_page.dart';
class CustomIcons {
  static const IconData menu = IconData(0xe900, fontFamily: "CustomIcons");
  static const IconData option = IconData(0xe902, fontFamily: "CustomIcons");
}
// List random = [
// ];
List aL = [];

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


class Detail extends StatefulWidget {
  final String context;
  final String popName;
  final List urlList;
  final String id;
  const Detail({Key? key, required this.context, required this.popName, required this.urlList, required this.id}) : super(key: key);
  @override
  _DetailState createState() => new _DetailState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _DetailState extends State<Detail> {
  var currentPage = 0 - 1.0;

  @override
  Widget build(BuildContext context) {
    aL = widget.urlList;
    // currentPage = widget.urlList.length - 1.0;
    PageController controller = PageController(initialPage: widget.urlList.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF1b1e44),
                Color(0xFF2d3447),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.popName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        randomImg();
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFFff6e6e),
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    //   child: Center(
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 22.0, vertical: 6.0),
                    //       child: Text("Artwork",
                    //           style: TextStyle(color: Colors.white)),
                    //     ),
                    //   ),
                    // ),

                    Text(widget.context,
                        style: TextStyle(color: Colors.blueAccent,fontSize: 20))
                  ],
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: widget.urlList.length,
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: home,
          tooltip: 'Pick Image',
          child: Icon(Icons.home),
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(
            FloatingActionButtonLocation.endFloat, 0, -50),
      ),
    );
  }

  Future<void> randomImg() async {
    CloudBaseAuthState authState = await auth.getAuthState();

    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('注册成功');
      }).catchError((err) {
        // 登录失败
        print('注册失败');
      });
    }else{
      print('jnkfj');
    }
    var a = Random().nextInt(18744);
    var _ = db.command;
    db.collection('idea').where({
      '_id': widget.id
    }).update({
      'like': _.inc(1)
    }).then((res) {
      print(widget.id);
      print(res);
      Fluttertoast.showToast(
          msg: "点赞成功！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
      // widget.urlList = res.data;
      // print(random);
    });
  }

  void back() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>  NavigationHomeScreen(),
        ));
  }

  void home() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>NavigationHomeScreen(),)).then(
            (data) {
          //data就等于xxxx getData()方法为重新获取数据方法
          getData();
        });
  }

  void getData() {}
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

        for (var i = 0; i < aL.length; i++) {
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
                      Image.network(cloudInfo.cloudUrlHttp+aL[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text('',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 12.0, bottom: 12.0),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 22.0, vertical: 6.0),
                            //     decoration: BoxDecoration(
                            //         color: Colors.blueAccent,
                            //         borderRadius: BorderRadius.circular(20.0)),
                            //     child: Text('hh',
                            //         style: TextStyle(color: Colors.white)),
                            //   ),
                            // )
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


}
