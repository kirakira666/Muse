import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muse/root_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTime = 6;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        _jumpRootPage();
      }
    });
  }

  void _jumpRootPage() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RootPage(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // top: MediaQuery.of(context).padding.top,
            // right: (MediaQuery.of(context).size.width-300)/2,
            child: _homeBack(),
          ),
          Positioned(
            // top: MediaQuery.of(context).padding.top+20,
            // right: (MediaQuery.of(context).size.width-300)/2,
            child: _homePic2(),
          ),
          Positioned(
            // top: MediaQuery.of(context).padding.top+20,
            // right: (MediaQuery.of(context).size.width-300)/2,
            child: _homePic3(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: InkWell(
              child: _homeJump(),
              onTap: _jumpRootPage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeCard() {
    return Container(
      width: 320,
      height: 250,
      decoration: new BoxDecoration(
          // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          color: Color.fromARGB(0, 57, 57, 57),
          borderRadius: new BorderRadius.circular((10.0))),
      child: Column(
        children: [
          Text(
            'MUSE',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                height: 4,
                fontWeight: FontWeight.w100,
                fontSize: 28),
          ),
          Text(
            'Fill the universe with romance.',
            style: TextStyle(
                wordSpacing: 2,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w100,
                // fontStyle: FontStyle.italic,
                fontSize: 22),
          ),
          Text(
            '——浪漫将宇宙填满——',
            style: TextStyle(
                wordSpacing: 2,
                height: 2,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w100,
                // fontStyle: FontStyle.italic,
                fontSize: 16),
          ),
          // Image.asset(
          //   'images/yhy.png',
          //   fit: BoxFit.cover,
          //   width: 300,
          //   height: 200,
          // )
        ],
      ),
    );
  }

  Widget _homePic() {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: 200,
            right: (MediaQuery.of(context).size.width - 300) / 2,
            child: Container(
              child: Image.asset(
                'assets/image/yhy.png',
                fit: BoxFit.contain,
                width: 300,
                // height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Image.asset(
            'assets/image/mon.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }
  Widget _homePic2() {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: 60,
            left: 80,
            child: Container(
              height: 140,
              decoration: new BoxDecoration(
                // border: new Border.all(width: 2.0, color: Colors.red),
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/image/yhy.png',
                  fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget _homePic3() {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: 35,
            right: 20,
            child: Text(
                '@Authored by kirakira666',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 14)),
          ),

        ],
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
            'assets/image/star.GIF',
            fit: BoxFit.cover,
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )
        ],
      ),
    );
  }

//跳过
  Widget _homeJump() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        decoration: new BoxDecoration(
          // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('跳过', style: TextStyle(color: Colors.white, fontSize: 12)),
            Text('${_currentTime}s',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
