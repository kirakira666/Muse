import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    CloudBaseCore core = CloudBaseCore.init({
      // 填写您的云开发 env
      'env': 'hello-cloudbase-0g101nj6c726535b',
      // 填写您的移动应用安全来源凭证
      // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
      'appAccess': {
        // 凭证
        'key': '11ffd6e8a530075da19065460253875d',
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

    // 请求参数
    Map<String, dynamic> data = {'a': 1111, 'b': 7872};
    CloudBaseResponse res = await cloudbase.callFunction('hhh', data);
    print(res.data);

    // Collection collection = db.collection('user');
    // var myOpenID = '247d14ad60b0e820013baad45340bff7';
    var _ = db.command;
    db.collection('user').get().then((res) {
      print(res.data[9]);
    });
    //上传
    // String path = await _getDocumentsPath();
    // CloudBaseStorage storage = CloudBaseStorage(core);
    // await storage.uploadFile(
    //     cloudPath: 'flutter/user.txt',
    //     filePath: '$path/user.txt',
    //     onProcess: (int count, int total) {
    //       // 当前进度
    //       print(count);
    //       // 总进度
    //       print(total);
    //     }
    // );
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  _getDocumentsPath() async {

    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    File file = new File('$path/user.txt');
    await file.writeAsString('contents');
    return path;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
