import 'package:flutter/material.dart';
import 'package:muse/test.dart';
import 'package:smart_flare/actors/pan_flare_actor.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_flare/actors/smart_flare_actor.dart';
import 'package:smart_flare/enums.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_flare/models.dart';

import 'aboutPic/index_pic.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  void _jumpSquarePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NavigationHomeScreen(),
        ));
  }

  void _jumpImgPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => IndexPic(
            page: 0,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: _rootBack(),
          ),
          Positioned(
            // top: MediaQuery.of(context).padding.top+20,
            // right: (MediaQuery.of(context).size.width-300)/2,
            child: _homePic(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            right: (MediaQuery.of(context).size.width - 330) / 2,
            child: _homeCard(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 30,
            left: 15,
            child: InkWell(
              child: _goShow(),
              onTap: () {
                _jumpSquarePage();
                print('show');
              },
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 30,
            right: 15,
            child: InkWell(
              child: _goFind(),
              onTap: () {
                _jumpImgPage();
                print('find');
              },
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

  Widget _rootBack() {
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

  Widget _goShow() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 65,
        height: 70,
        decoration: new BoxDecoration(
          // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          color: Colors.white.withOpacity(0.75),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: InkWell(
                highlightColor: Colors.transparent,
                borderRadius: const BorderRadius.all(
                    Radius.circular(32.0)),
                onTap: () {
                  print('show');
                  _jumpSquarePage();
                },
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
            Text('Show', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300,fontSize: 14)),
            // Text('${_currentTime}s', style: TextStyle(color: Colors.white,fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _goFind() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 65,
        height: 70,
        decoration: new BoxDecoration(
          // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          color: Colors.white.withOpacity(0.75),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: InkWell(
                highlightColor: Colors.transparent,
                borderRadius: const BorderRadius.all(
                    Radius.circular(32.0)),
                onTap: () {
                  print('Find');
                  _jumpImgPage();
                },
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
            Text('Find', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300,fontSize: 14)),
            // Text('${_currentTime}s', style: TextStyle(color: Colors.white,fontSize: 12)),
          ],
        ),
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
      // decoration: new BoxDecoration(
      //   // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
      //     color: Color.fromARGB(255, 57, 57, 57),
      //     borderRadius: new BorderRadius.circular((10.0))),
      child: Stack(
        children: [
          // Image.asset(
          //   'images/ccchhh.GIF',
          //   fit: BoxFit.contain,
          //   width: MediaQuery.of(context).size.width,
          // ),
          // Image.asset(
          //   'images/hhh.png',
          //   fit: BoxFit.contain,
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          // ),

          Positioned(
            bottom: 200,
            right: (MediaQuery.of(context).size.width - 300) / 2,
            child: Container(
              child: Image.asset(
                'images/yhy.png',
                fit: BoxFit.contain,
                width: 300,
                // height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Image.asset(
            'images/mon.png',
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
      // decoration: new BoxDecoration(
      //   // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
      //     color: Color.fromARGB(255, 57, 57, 57),
      //     borderRadius: new BorderRadius.circular((10.0))),
      child: Stack(
        children: [
          // Image.asset(
          //   'images/ccchhh.GIF',
          //   fit: BoxFit.contain,
          //   width: MediaQuery.of(context).size.width,
          // ),
          // Image.asset(
          //   'images/hhh.png',
          //   fit: BoxFit.contain,
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          // ),

          Positioned(
            bottom: 340,
            left: 100,
            child: Container(
              height: 90,
              decoration: new BoxDecoration(
                // border: new Border.all(width: 2.0, color: Colors.red),
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/zqb1.png',
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
            bottom: 130,
            left: 170,
            child: Text(
                '@Authored by kirakira666',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14)),
          ),

        ],
      ),
    );
  }

  Widget _homePic4() {
    return Container(
      // decoration: new BoxDecoration(
      //   // border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
      //     color: Color.fromARGB(255, 57, 57, 57),
      //     borderRadius: new BorderRadius.circular((10.0))),
      child: Stack(
        children: [
          // Image.asset(
          //   'images/ccchhh.GIF',
          //   fit: BoxFit.contain,
          //   width: MediaQuery.of(context).size.width,
          // ),
          // Image.asset(
          //   'images/hhh.png',
          //   fit: BoxFit.contain,
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          // ),
          Positioned(
            bottom: 230,
            left: 250,
            child: Container(
              height: 30,
              width: 80,
              decoration: new BoxDecoration(
                color: Color(0xFFD0D4E2),
                // border: new Border.all(width: 2.0, color: Colors.red),
                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      '   Q&A',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 15)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 290,
            left: 250,
            child: Container(
                height: 30,
                width: 80,
                decoration: new BoxDecoration(

                  color: Color(0xFFD0D4E2),
                  // border: new Border.all(width: 2.0, color: Colors.red),
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      '   建议',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 15)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            left: 250,
            child: Container(
              height: 30,
              width: 80,
              decoration: new BoxDecoration(

                color: Color(0xFFD0D4E2),
                // border: new Border.all(width: 2.0, color: Colors.red),
                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      '   关于',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 15)),
                ],
              )
            ),
          ),

        ],
      ),
    );
  }
}

