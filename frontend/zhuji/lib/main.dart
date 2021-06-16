// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:cloudbase_core/cloudbase_core.dart';
// import 'package:cloudbase_auth/cloudbase_auth.dart';
// import 'package:cloudbase_database/cloudbase_database.dart';
// import 'package:cloudbase_function/cloudbase_function.dart';
// import 'package:cloudbase_storage/cloudbase_storage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   Future<void> _incrementCounter() async {
//     CloudBaseCore core = CloudBaseCore.init({
//       // 填写您的云开发 env
//       'env': 'zhuji-cloudbase-3g9902drd47633ab',
//       // 填写您的移动应用安全来源凭证
//       // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
//       'appAccess': {
//         // 凭证
//         'key': '5fec06cf15598021bbbf79758129b41d',
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
//     db.collection('user').get().then((res) {
//       print(res);
//     });
//     // //上传
//     // String path = await _getDocumentsPath();
//     // CloudBaseStorage storage = CloudBaseStorage(core);
//     // await storage.uploadFile(
//     //     cloudPath: 'flutter/user.txt',
//     //     filePath: '$path/user.txt',
//     //     onProcess: (int count, int total) {
//     //       // 当前进度
//     //       print(count);
//     //       // 总进度
//     //       print(total);
//     //     }
//     // );
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   _getDocumentsPath() async {
//
//     final directory = await getApplicationDocumentsDirectory();
//     String path = directory.path;
//     File file = new File('$path/user.txt');
//     await file.writeAsString('contents');
//     return path;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'HttpUtil.dart';
import 'dart:io';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:zhuji/color_thief_flutter.dart';
import 'package:zhuji/utils.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(new MaterialApp(
    title: 'input',
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('muse'),
      ),
      body: new MyWeather(),
    ),
  ));
}

class MyWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyWeatherState();
  }
}

class MyWeatherState extends State<MyWeather> with NetListener {
  var weather = 'delay';
  var imgUrl = 'https://picsum.photos/580/600/?image=' + '269';
  HttpManager httpManager = new HttpManager();
  var backA = 150;
  var backR = 256;
  var backG = 256;
  var backB = 256;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Container(
      decoration: new BoxDecoration(
        color: Color.fromARGB(backA, backR, backG, backB),
      ),
      child: new Column(
        children: <Widget>[
          new RaisedButton(
              child: new Text('三天的预报'),
              onPressed: () {
                _getWeatherForecast();
              }),
          new RaisedButton(
              child: new Text('获取实时天气'),
              onPressed: () {
                _getWeatherNewWeather();
              }),
          new Expanded(
              child: new Center(
            child: new ListView(
              children: <Widget>[
                new Text('$weather'),
                new Image.network(
                  //图片地址
                  '$imgUrl',
                  //填充模式
                  fit: BoxFit.fitWidth,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  /**
   * 获取三天的预报
   */
  _getWeatherForecast() async {
    print('请求获取三天的预报');
    await httpManager.getForecast(this, '朝阳区');
  }

  /**
   * 获取实况天气
   */
  _getWeatherNewWeather() async {
    await httpManager.getNewWeather(this, "浦东新区");
  }

  /**
   * 获取实况天气
   */
  @override
  Future<void> onNewWeatherResponse(String body) async {

    String scopeF = '123456789'; //首位
    String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < 3; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    final url = 'https://picsum.photos/580/600/?image=' + result;
    imgUrl = url;
    final imageProvider = NetworkImage(url);
    // 提取网络图片的主要颜色
    getColorFromUrl(url).then((color) {
      print('主要颜色');
      print(color); // [R,G,B]
      backR = color[0];
      backG = color[1];
      backB = color[2];
      setState(() {});
    });
    // 提取网络图片调色板
    getPaletteFromUrl(url).then((palette) {
      print('调色板');
      print(palette); // [[R,G,B]]
    });
    // 提取网络图片的实际图片
    getImageFromUrl(url).then((image) {
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

    // utils.dart
    // RGB 转换为 HSV
    final hsv = fromRGBtoHSV([90, 90, 90]);
    print(hsv); // [H,S,V]
    // HSV 转换为 RGB
    final rgb = fromHSVtoRGB([90, 90, 90]);
    print(rgb); // [R,B,G]

    CloudBaseCore core = CloudBaseCore.init({
      // 填写您的云开发 env
      'env': 'zhuji-cloudbase-3g9902drd47633ab',
      // 填写您的移动应用安全来源凭证
      // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
      'appAccess': {
        // 凭证
        'key': '5fec06cf15598021bbbf79758129b41d',
        // 版本
        'version': '1'
      },
      // 请求超时时间（选填）
      'timeout': 3000
    });
    print('hhh');
    CloudBaseAuth auth = CloudBaseAuth(core);
    CloudBaseDatabase db = CloudBaseDatabase(core);
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

// 获取用户信息
    if (authState != null) {
      await auth.getUserInfo().then((userInfo) {
        // 获取用户信息成功
        print(userInfo);
      }).catchError((err) {
        print('erro');
        // 获取用户信息失败
      });
    }
    CloudBaseFunction cloudbase = CloudBaseFunction(core);

    // 云函数
    Map<String, dynamic> data = {'a': 1111, 'b': 7872};
    CloudBaseResponse res = await cloudbase.callFunction('hhh', data);
    print(res.data);

    //数据库连接
    var _ = db.command;
    var re;
    db.collection('user').get().then((res) {
      re = res.data[2];
      print(re['_id']);
      weather = re['_id'];
      setState(() {});
    });
    // print(re);

    // setState(() {});
  }

  @override
  void onError(error) {
    // TODO: implement onError
  }

  @override
  void onForecastResponse(String body) {
    print('响应获取三天的预报');
    weather = body;
    print(body);
    setState(() {});
  }
}
