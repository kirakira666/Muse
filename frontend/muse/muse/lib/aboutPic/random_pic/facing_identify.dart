import 'dart:convert';
import 'dart:convert' as convert;
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:muse/aboutPic/color_picker_pic/water_view.dart';
import 'package:muse/aboutPic/facing/encode_util.dart';
class CustomIcons {
  static const IconData menu = IconData(0xe900, fontFamily: "CustomIcons");
  static const IconData option = IconData(0xe902, fontFamily: "CustomIcons");
}
List random = [
];
List<String> images = [
  "images/1.gif",
  "images/2.gif",
  "images/3.gif",
  "images/4.gif",
  "images/5.gif"
];

List<String> title = [
  "1",
  "2",
  "3",
  "4",
  "5"
];
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
bool obscureText = false;
String username = '';
bool hhh = false;
String pwd = '';
var content = 'hhh';
var currImg = null;
List _imageList = []; //图片列表
int _photoIndex = 0; //选择拍照还是相册的索引
List _actionSheet = [
  // {"name": "拍照", "icon": Icon(Icons.camera_alt)},
  {"name": "相册", "icon": Icon(Icons.photo)}
];

class FacingIdentify extends StatefulWidget {
  final AnimationController animationController;

  const FacingIdentify({Key? key, required this.animationController}) : super(key: key);
  @override
  _FacingIdentifyState createState() => new _FacingIdentifyState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _FacingIdentifyState extends State<FacingIdentify> with TickerProviderStateMixin{
  var currentPage = images.length - 1.0;


  @override
  Widget build(BuildContext context) {

    PageController controller = PageController(initialPage: images.length - 1);
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
        body: Stack(
          children: [
            Positioned(
              // top: MediaQuery.of(context).padding.top,
              // right: (MediaQuery.of(context).size.width-300)/2,
              child: _homeBack(),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Art Faces!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 46.0,
                              fontFamily: "Calibre-Semibold",
                              letterSpacing: 1.0,
                            )),
                        SizedBox(
                          height: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_box,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              print('照片');_getActionSheet();
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  hhhImg(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                            onTap: (){print('提交');faceSearch();},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFff6e6e),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 6.0),
                                  child: Text("Explore",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text("Explore your face in artworks!",
                            style: TextStyle(color: Colors.blueAccent))
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      CardScrollWidget(currentPage),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: images.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),

                  WaterView(
                    mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.animationController,
                            curve: Interval((1 / 9) * 7, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    mainScreenAnimationController: widget.animationController, valuePer: ddvalue(currentPage),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _homeBack() {
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


  Widget hhhImg() {
    return currImg != null
        ? Wrap(
      spacing: 10.0,
      children: _getImageList(),
    )
        : InkWell(
        onTap: (){print('图片');_getActionSheet();},
        child: SizedBox(
          height: 300,
          child: Image.asset(
            'images/1.gif',
            fit: BoxFit.cover,
            width: 300.0,
            height: 260.0,
          ),
        )
    );
  }
  List<Widget> _getImageList() {
    return _imageList.map((img) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            InkWell(
                onTap: (){print('图片');_getActionSheet();},
                child: Image.file(
                  currImg,
                  fit: BoxFit.cover,
                  width: 300.0,
                  height: 260.0,
                )
            ),
            Positioned(
              right: 5.0,
              top: 5.0,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    color: Colors.lightBlue,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _imageList.remove(currImg);
                  });
                },
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  //获取sheet选择
  Future _getActionSheet() async {
    await showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _actionSheet.length,
              itemExtent: 50.0,
              itemBuilder: (innerCtx, i) {
                return ListTile(
                  title: Text(_actionSheet[i]["name"]),
                  leading: _actionSheet[i]["icon"],
                  onTap: () {
                    setState(() {
                      _photoIndex = 1;
                    });
                    _getImage();
                  },
                );
              },
            ),
          );
        });
  }

  Future _getImage() async {
    Navigator.of(context).pop();
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //没有选择图片或者没有拍照
    if (image != null) {
      setState(() {
        _imageList=[];
        _imageList.add(image);
        currImg = image;
      });
    }
  }

  Future<void> faceSearch() async {
    random=[];
    print(_imageList[0].path);
    EncodeUtil.image2Base64(_imageList[0].path).then((data){
      String imageBase64=data;
      // print(imageBase64);
      var client = new http.Client();
      var time = new DateTime.now().millisecondsSinceEpoch;
      int a = 5;
      client.post(
          'https://api-cn.faceplusplus.com/facepp/v3/search',
          body: {
            "api_key":"3tWnsEAOU1dL9PlOh40PV3p2LdVDZEhG",
            "api_secret": "VWtztt1p8Alss_PZNIHuH5xUrJWi59b7",
            "image_base64": imageBase64,
            "outer_id": "artworkFaceKira666",
            'return_result_count': '5'
          }
      ).then((response) async {
        // Map<String, dynamic> aaaa =convert.jsonDecode(response.body);
        String hh = response.body;
        List hhList  = hh.split('"');
        print(hh);
        print(hhList[85]);
        print(hhList[75]);
        print(hhList[65]);
        print(hhList[55]);
        print(hhList[45]);

        String a5 = hhList[85];
        String a4 = hhList[75];
        String a3 = hhList[65];
        String a2 = hhList[55];
        String a1 = hhList[45];
        // print(response.headers['faces']);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => IndexPic(),
        //     ));
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
        db.collection('face').limit(5).where({
          'face_token': _.eq(a1)
        }).get().then((res) {
          random.add(res.data[0]);
          Fluttertoast.showToast(
              msg: "人脸匹配成功！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 13.0
          );
          print(res);
        });
        db.collection('face').limit(5).where({
          'face_token': _.eq(a2)
        }).get().then((res) {
          random.add(res.data[0]);
          print(res);
        });
        db.collection('face').limit(5).where({
          'face_token': _.eq(a3)
        }).get().then((res) {
          random.add(res.data[0]);
          print(res);
        });
        db.collection('face').limit(5).where({
          'face_token': _.eq(a4)
        }).get().then((res) {
          random.add(res.data[0]);
          print(res);
        });
        db.collection('face').limit(5).where({
          'face_token': _.eq(a5)
        }).get().then((res) {
          random.add(res.data[0]);
          print(res);
        });
      },onError: (error){
        print(error);
      }).whenComplete(
          client.close
      );
    });
  }
  Future<void> getFaceImg() async {

  }

  double ddvalue(double currentPage) {
    return 10.0*currentPage+22.8;
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
                                child: Text(ll(5-i),
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

  String ll(i) {
    if(i == 1){
      return '1st';
    }else if(i == 2){
      return '2nd';
    }else if(i == 3){
      return '3rd';
    }
    return i.toString()+'th';
  }


}
