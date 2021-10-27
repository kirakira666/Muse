import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:muse/show/welcome_page.dart';
import 'package:muse/root_page.dart';
import 'package:muse/utils/cloud_utils.dart';
import 'package:muse/utils/storage_util.dart';

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

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      required this.screenIndex,
      required this.iconAnimationController,
      required this.callBackIndex,
      required this.username})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;
  final String username;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late List<DrawerList> drawerList;

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Cancellation,
        labelName: 'Cancellation',
        icon: Icon(Icons.cancel),
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'FeedBack',
        icon: Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: 'Invite Friend',
        icon: Icon(Icons.group),
      ),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Rate the app',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'About Us',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                      animation: widget.iconAnimationController,
                      builder: builderAni),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      widget.username,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  onTapped();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void onTapped() {
    print('Doing Something...');
    _logout();
    // Print to console.
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
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => RootPage(),
          ));
    } else {
      Fluttertoast.showToast(
          msg: "当前处于未登陆状态！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0);
    }
  }

  Future<void> _Cancellationt() async {
    String token = await StorageUtil.getStringItem('username');
    if (token != null) {
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
      Fluttertoast.showToast(
          msg: "退出登录并注销！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0);
      var _ = db.command;
      db
          .collection('user')
          .where({'username': token})
          .remove()
          .then((res) {
        Fluttertoast.showToast(
            msg: "注销成功！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 13.0);
        StorageUtil.remove('username');
        StorageUtil.remove('pwd');
            print(res);
          })
          .catchError((e) {});
      print('yijdl');


    } else {
      Fluttertoast.showToast(
          msg: "当前处于未登陆状态！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0);
    }
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
          print(listData.index.toString());
          if (listData.index.toString() == 'DrawerIndex.Cancellation') {
            print('11');
            _Cancellationt();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RootPage(),
                ));
          }
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: hhBuilder,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }

  Widget builderAni(BuildContext context, Widget? child) {
    return ScaleTransition(
      scale: AlwaysStoppedAnimation<double>(
          1.0 - (widget.iconAnimationController.value) * 0.2),
      child: RotationTransition(
        turns: AlwaysStoppedAnimation<double>(
            Tween<double>(begin: 0.0, end: 24.0)
                    .animate(CurvedAnimation(
                        parent: widget.iconAnimationController,
                        curve: Curves.fastOutSlowIn))
                    .value /
                360),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.6),
                  offset: const Offset(2.0, 4.0),
                  blurRadius: 8),
            ],
          ),
          child: InkWell(
            onTap: () {
              print('登录');
              _jumpLoginPage();
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60.0)),
              child: Image.asset('assets/image/1.gif'),
            ),
          ),
        ),
      ),
    );
  }

  Widget hhBuilder(BuildContext context, Widget? child) {
    return Transform(
      transform: Matrix4.translationValues(
          (MediaQuery.of(context).size.width * 0.75 - 64) *
              (1.0 - widget.iconAnimationController.value - 1.0),
          0.0,
          0.0),
      child: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75 - 64,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(28),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
      ),
    );
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
          timeInSecForIos: 1,
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
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Cancellation,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    required this.icon,
    required this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
