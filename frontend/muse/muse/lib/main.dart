import 'dart:io';
// import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:muse/home.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muse',
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}


// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'HttpUtil.dart';
// import 'dart:io';
// import 'package:cloudbase_core/cloudbase_core.dart';
// import 'package:cloudbase_auth/cloudbase_auth.dart';
// import 'package:cloudbase_database/cloudbase_database.dart';
// import 'package:cloudbase_function/cloudbase_function.dart';
// import 'package:muse/color_thief_flutter.dart';
// import 'package:muse/utils.dart';
// import 'package:cloudbase_storage/cloudbase_storage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// void main() {
//   runApp(new MaterialApp(
//     title: 'muse',
//     home: new Scaffold(
//       appBar: new AppBar(
//         title: new Text('muse'),
//       ),
//       body: new MyWeather(),
//
//
//     ),
//   ));
// }
//
// class MyWeather extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return new MyWeatherState();
//   }
// }
//
// class MyWeatherState extends State<MyWeather> with NetListener {
//   var weather = 'delay';
//   var imgUrl = 'https://www.nbfox.com/wp-content/uploads/2020/09/24/20200924222056-5f6cab48d44d8.jpg';
//   // var imgUrl = 'https://picsum.photos/580/600/?image=' + '269';
//   HttpManager httpManager = new HttpManager();
//   var backA = 150;
//   var backR = 256;
//   var backG = 256;
//   var backB = 256;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     return new Container(
//       decoration: new BoxDecoration(
//         color: Color.fromARGB(backA, backR, backG, backB),
//       ),
//       child: new Column(
//         children: <Widget>[
//           // new RaisedButton(
//           //     child: new Text('三天的预报'),
//           //     onPressed: () {
//           //       _getWeatherForecast();
//           //     }),
//           new RaisedButton(
//               child: new Text('刷新图片'),
//               onPressed: () {
//                 _getWeatherNewWeather();
//               }),
//           new Expanded(
//               child: new Center(
//                 child: new ListView(
//                   children: <Widget>[
//                     // new Text('$weather'),
//                     new Image.network(
//                       //图片地址
//                       '$imgUrl',
//                       //填充模式
//                       fit: BoxFit.fitWidth,
//                     )
//                   ],
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
//
//   /**
//    * 获取三天的预报
//    */
//   _getWeatherForecast() async {
//     print('请求获取三天的预报');
//     await httpManager.getForecast(this, '朝阳区');
//   }
//
//   /**
//    * 获取实况天气
//    */
//   _getWeatherNewWeather() async {
//     await httpManager.getNewWeather(this, "浦东新区");
//   }
//
//   /**
//    * 获取实况天气
//    */
//   @override
//   Future<void> onNewWeatherResponse(String body) async {
//
//     String scopeF = '123456789'; //首位
//     String scopeC = '0123456789'; //中间
//     int x = Random().nextInt(18750);
//
//     CloudBaseCore core = CloudBaseCore.init({
//       // 填写您的云开发 env
//       'env': 'zhuji-cloudbase-3g9902drd47633ab',
//       // 填写您的移动应用安全来源凭证
//       // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
//       'appAccess': {
//         // 凭证
//         'key': 'e6f33326a0d40fecfc67ffc2877255bc',
//         // 版本
//         'version': '1'
//       },
//       // 请求超时时间（选填）
//       'timeout': 3000
//     });
//     print('hhh');
//     CloudBaseAuth auth = CloudBaseAuth(core);
//     CloudBaseDatabase db = CloudBaseDatabase(core);
//     CloudBaseAuthState authState = await auth.getAuthState();
//
// // 唤起匿名登录
//     if (authState == null) {
//       await auth.signInAnonymously().then((success) {
//         // 登录成功
//         print('登录成功');
//       }).catchError((err) {
//         // 登录失败
//         print('登录失败');
//       });
//     }
//
// // 获取用户信息
//     if (authState != null) {
//       await auth.getUserInfo().then((userInfo) {
//         // 获取用户信息成功
//         print(userInfo);
//       }).catchError((err) {
//         print('erro');
//         // 获取用户信息失败
//       });
//     }
//     CloudBaseFunction cloudbase = CloudBaseFunction(core);
//
//     // 云函数
//     Map<String, dynamic> data = {'a': 1111, 'b': 7872};
//     CloudBaseResponse res = await cloudbase.callFunction('hhh', data);
//     print(res.data);
//
//     //数据库连接
//     var _ = db.command;
//     var re;
//     db.collection('artwork').where({
//       'index': _.eq(x)
//     }).get().then((res) {
//       re = res.data[0]['picUrl'];
//       print(re);
//       imgUrl = re;
//       // weather = re['_id'];
//       final imageProvider = NetworkImage(imgUrl);
//       // 提取网络图片的主要颜色
//       getColorFromUrl(imgUrl).then((color) {
//         print('主要颜色');
//         print(color); // [R,G,B]
//         backR = color[0];
//         backG = color[1];
//         backB = color[2];
//         setState(() {});
//       });
//       // 提取网络图片调色板
//       getPaletteFromUrl(imgUrl).then((palette) {
//         print('调色板');
//         print(palette); // [[R,G,B]]
//       });
//       // 提取网络图片的实际图片
//       getImageFromUrl(imgUrl).then((image) {
//         print(image); // Image
//       });
//       // 提取 ImageProvider 的实际图片
//       getImageFromProvider(imageProvider).then((image) {
//         print(image); // Image
//         // 从图片提取主要颜色
//         getColorFromImage(image).then((color) {
//           print('主要颜色');
//           print(color); // [R,G,B]
//         });
//         // 从图片提取调色板
//         getPaletteFromImage(image).then((palette) {
//           print('调色板');
//           print(palette); // [[R,G,B]]
//         });
//       });
//
//       // utils.dart
//       // RGB 转换为 HSV
//       final hsv = fromRGBtoHSV([90, 90, 90]);
//       print(hsv); // [H,S,V]
//       // HSV 转换为 RGB
//       final rgb = fromHSVtoRGB([90, 90, 90]);
//       print(rgb); // [R,B,G]
//       setState(() {});
//     });
//     // print(re);
//
//
//     setState(() {});
//   }
//
//   @override
//   void onError(error) {
//     // TODO: implement onError
//   }
//
//   @override
//   void onForecastResponse(String body) {
//     print('响应获取三天的预报');
//     weather = body;
//     print(body);
//     setState(() {});
//   }
// }
