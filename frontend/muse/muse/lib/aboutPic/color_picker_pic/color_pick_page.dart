import 'package:flutter/material.dart';

import 'color_pick_view.dart';
class ColorPickPage extends StatefulWidget {
  ColorPickPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ColorPickPageState createState() => _ColorPickPageState();
}


class _ColorPickPageState extends State<ColorPickPage> {
  Color currentColor = Color(0xff0000ff);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    callPic();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        // appBar: AppBar(
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text(widget.title),
        // ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 200,
            child: ColorPickView(
            selectColor: Color(0xff0000ff),
            selectRadius: 600,
            selectRingColor: Color(0xff0000ff),
            size: Size(300, 300),
            padding: 10,
            selectColorCallBack: (Color color) {

              currentColor = color;
              print(currentColor);
              return color;
            },
          ),
          ),

        ],
      ),
    );
  }

  void callPic() {

  }
}
