import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/page/login_page.dart';
import 'package:muse/theme/app_size.dart';
import 'package:muse/theme/app_style.dart';
import 'package:muse/widgets/welcome_widget.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:muse/color_thief_flutter.dart';




///登录页面剪裁曲线
class SignClipper extends CustomClipper<Path> {
  // 第一个点
  Point p1 = Point(0.0, 54.0);
  Point c1 = Point(20.0, 25.0);
  Point c2 = Point(81.0, -8.0);

  // 第二个点
  Point p2 = Point(160.0, 20.0);
  Point c3 = Point(216.0, 38.0);
  Point c4 = Point(280.0, 73.0);

  // 第三个点
  Point p3 = Point(280.0, 44.0);
  Point c5 = Point(280.0, -11.0);
  Point c6 = Point(330.0, 8.0);

  @override
  Path getClip(Size size) {
    // 第四个点
    Point p4 = Point(size.width, .0);

    Path path = Path();
    // 移动到第一个点
    path.moveTo(
        double.parse((p1.x).toString()), double.parse((p1.y).toString()));
    //第一阶段 三阶贝塞尔曲线
    path.cubicTo(
        double.parse((c1.x).toString()),
        double.parse((c1.y).toString()),
        double.parse((c2.x).toString()),
        double.parse((c2.y).toString()),
        double.parse((p2.x).toString()),
        double.parse((p2.y).toString()));
    //第二阶段 三阶贝塞尔曲线
    path.cubicTo(
        double.parse((c3.x).toString()),
        double.parse((c3.y).toString()),
        double.parse((c4.x).toString()),
        double.parse((c4.y).toString()),
        double.parse((p3.x).toString()),
        double.parse((p3.y).toString()));
    // (c3.x, c3.y, c4.x, c4.y, p3.x, p3.y);
    //第三阶段 三阶贝塞尔曲线
    path.cubicTo(
        double.parse((c5.x).toString()),
        double.parse((c5.y).toString()),
        double.parse((c6.x).toString()),
        double.parse((c6.y).toString()),
        double.parse((p4.x).toString()),
        double.parse((p4.y).toString()));
    // (c5.x, c5.y, c6.x, c6.y, p4.x, p4.y);
    // 连接到右下角
    path.lineTo(size.width, size.height);
    // 连接到左下角
    path.lineTo(0, size.height);
    //闭合
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this.hashCode != oldClipper.hashCode;
  }
}
String isSE = '';
String username = '';
bool hhh = false;
String pwd = '';
var context1 = null;
var backA = 150;
var backR = 256;
var backG = 256;
var backB = 256;
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

/// 登录图标按钮
class SignBtnIconWidget extends StatelessWidget {
  const SignBtnIconWidget({
    Key? key,
  }) : super(key: key);

  void _getPaint() {
    int x = Random().nextInt(18750);
    //数据库连接
    var _ = db.command;
    var re;
    db.collection('artwork').where({
      'index': _.eq(x)
    }).get().then((res) {
      re = res.data[0]['picUrl'];
      print(res.data);
      print(re);
      final imageProvider = NetworkImage(re);
      // 提取网络图片的主要颜色
      getColorFromUrl(re).then((color) {
        print('主要颜色');
        print(color); // [R,G,B]
        backR = color[0];
        backG = color[1];
        backB = color[2];
      });
      // 提取网络图片调色板
      getPaletteFromUrl(re).then((palette) {
        print('调色板');
        print(palette); // [[R,G,B]]
      });
      // 提取网络图片的实际图片
      getImageFromUrl(re).then((image) {
        print(image); // Image
      });
      // 提取 ImageProvider 的实际图片
      getImageFromProvider(imageProvider).then((image) {
        print(image); // Image
        // 从图片提取主要颜色
        getColorFromImage(image).then((color) {
          print('主要颜色');
          print(color); // [R,G,B]
        });
        // 从图片提取调色板
        getPaletteFromImage(image).then((palette) {
          print('调色板');
          print(palette); // [[R,G,B]]
        });
      });
    });
  }

  Future<void> _signUp() async {
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
    db.collection('user').add({
      'username': username,
      'pwd':pwd,
      'idea':[],
      'like':[],
      'collect':[]
    }).then((res) {
      hhh = false;
      print(res.id);
      if(res.id==null){
        print('用户名占用');
        Fluttertoast.showToast(
            msg: "用户名已被占用",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 13.0
        );
      }else{
        print('注册成功');
        // this. = res.id;
        hhh = true;
        Fluttertoast.showToast(
            msg: "创建成功，请登录！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 13.0
        );
        Navigator.pushAndRemoveUntil(
            context1,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
                (route) => false);
      }
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "注册失败！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 13.0
      );
    });
    // return isSe;
  }

  @override
  Widget build(BuildContext context) {
    context1 = context;
    return Row(
      children: [
        Spacer(),
        GradientBtnWidget(
            width: 160,
            child: Row(
              children: [
                SizedBox(width: 34),
                BtnTextWhiteWidget(
                  text: 'Sign Up',
                ),
                Spacer(),
                Image.asset(
                  'assets/icons/icon_arrow_right.png',
                  width: kIconSize,
                  height: kIconSize,
                ),
                SizedBox(width: 24),
              ],
            ),
            onTap: (){
              _signUp();
            })
      ],
    );
  }

  Future<void> sign() async {
    print(username);
    print(pwd);


    CloudBaseAuthState authState = await auth.getAuthState();
// 唤起匿名登录
    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('登录成功');
      }).catchError((err) {
        // 登录失败
        print('登录失败');
      });
    }
    // _getPaint();
    // Navigator.pop(context);
  }
}

///登录输入框
class SignInput extends StatelessWidget {
  const SignInput({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
  }) : super(key: key);

  final String hintText;
  final String prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: kInputBorder,
        focusedBorder: kInputBorder,
        enabledBorder: kInputBorder,
        prefixIcon: Container(
          width: kIconBoxSize,
          height: kIconBoxSize,
          alignment: Alignment.center,
          child: Image.asset(
            prefixIcon,
            width: kIconSize,
            height: kIconSize,
          ),
        ),
      ),
      obscuringCharacter: '*',
      obscureText: obscureText,
      style: kBodyTextStyle.copyWith(
        fontSize: 18,
      ),
      onChanged: (text) {
        if (obscureText) {
          print('pwd,' + text);
          pwd = text;
        } else {
          username = text;
          print('ema,' + text);
        }
      },
    );
  }
}

/// 返回图标
class BackIcon extends StatelessWidget {
  const BackIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: kIconBoxSize,
        height: kIconBoxSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/icons/icon_back.png',
          width: kIconSize,
          height: kIconSize,
        ),
      ),
    );
  }
}
