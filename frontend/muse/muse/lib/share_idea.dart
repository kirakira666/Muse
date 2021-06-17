import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
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

class ShareIdea extends StatefulWidget {
  const ShareIdea({Key? key}) : super(key: key);

  @override
  _ShareIdeaState createState() => _ShareIdeaState();
}

class _ShareIdeaState extends State<ShareIdea> {
  var content = 'hhh';
  void _jumpDetailPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Detail(),
        ));
  }

  Future<void> _jumpLoginPage() async {
    String token = await StorageUtil.getStringItem('username');
    if (token != null) {
      // 跳转到首页
      print('yijdl');
      Fluttertoast.showToast(
          msg: "已经登录！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0);
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
    String token = await StorageUtil.getStringItem('username');
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
          fontSize: 13.0);
    } else {
      Fluttertoast.showToast(
          msg: "当前处于未登陆状态！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0);
    }
  }

  var _imgPath;
  List _imageList = []; //图片列表
  int _photoIndex = 0; //选择拍照还是相册的索引
  List _actionSheet = [
    {"name": "拍照", "icon": Icon(Icons.camera_alt)},
    {"name": "相册", "icon": Icon(Icons.photo)}
  ];

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
          // Positioned(
          //   // child: _rootBack(),
          //   child: Container(
          //     child: Text(
          //       'SHARE',
          //       style: TextStyle(
          //           color: Color.fromARGB(255, 19, 22, 64),
          //           height: 4,
          //           fontWeight: FontWeight.w100,
          //           fontSize: 28),
          //     ),
          //   ),
          // ),
          Positioned(
            // child: _rootBack(),
            top: MediaQuery.of(context).padding.top + 60,
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("拍照"),
                  onPressed: () => _getActionSheet(),
                ),
                RaisedButton(
                  child: Text("提交"),
                  onPressed: () => {_pushDB()},
                ),
                Text("----照片列表----"),
                _imageList.isNotEmpty
                    ? Wrap(
                        spacing: 10.0,
                        children: _getImageList(),
                      )
                    : Text("暂无内容")
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: SmartFlareActor(
          //     width: animationWidth,
          //     height: animationHeight,
          //     filename: 'images/button-animation.flr',
          //     startingAnimation: 'deactivate',
          //     activeAreas: activeAreas,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
  }

  // _takePhoto() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     _imgPath = image;
  //   });
  // }
  //
  // /*相册*/
  // _openGallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _imgPath = image;
  //   });
  // }

  //图片列表的刻画
  List<Widget> _getImageList() {
    return _imageList.map((img) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Image.file(
              img,
              fit: BoxFit.cover,
              width: 100.0,
              height: 70.0,
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
                    _imageList.remove(img);
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
                      _photoIndex = i;
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
    var image = await ImagePicker.pickImage(
        source: _photoIndex == 0 ? ImageSource.camera : ImageSource.gallery);

    //没有选择图片或者没有拍照
    if (image != null) {
      setState(() {
        _imageList.add(image);
      });
    }
  }

  Future<void> _pushDB() async {
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
    CloudBaseStorage storage = CloudBaseStorage(core);
    CloudBaseAuthState authState = await auth.getAuthState();
    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('mm成功');
      }).catchError((err) {
        // 登录失败
        print('mm失败');
      });
    }
    String token = await StorageUtil.getStringItem('username');
    var _ = db.command;
    var o = {
      'i':'ms',
      '1':'hh'
    };
    var time = new DateTime.now().millisecondsSinceEpoch;
    var urlL = [];
    print(time);
    for(int i = 0;i<_imageList.length;++i){
      print(_imageList[i].path);
      var filepath = _imageList[i].path;
      var list = _imageList[i].path.split('/');
      var filename = list[list.length-1];
      print(filename);
      var urlPath = 'userIdea/$token/$time/$i.png';
      print(urlPath);
      urlL.add(urlPath);
      print(filepath);
      await storage.uploadFile(
          cloudPath: urlPath,
          filePath: filepath,
          onProcess: (int count, int total) {
            // 当前进度
            print(count);
            // 总进度
            print(total);
          }
      );
      print('发表');
    }
    db.collection('idea').add({
      'username': token,
      'time': time,
      'url': urlL,
    }).then((res) {

    }).catchError((e) {

    });
    // db.collection('user').where({
    //   'username': token
    // }).get().then((res) async {
    //   var index = (res.data[0]['idea'].length).toString();
    //   print(index);
    //   content = content+'@@@&%'+index;
    //   db.collection('user').where({'username': token}).update({
    //     'data': _.push(content)
    //   }).then((res) async {
    //     print(res);
    //
    //   });
    // });
  }
}
