import 'package:flutter/material.dart';
import 'package:muse/show/app_size_extension.dart';
import 'package:muse/show/login_page.dart';
import 'package:muse/show/sign_up_page.dart';
import 'package:muse/theme/app_colors.dart';
import 'package:muse/show/widgets/welcome_widget.dart';

// 欢迎页面
class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    /// 初始化配置App基准大小
    AppSizeConfig.initScreen(context);
    return Scaffold(
      backgroundColor: kBgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          WelcomeHeaderWidget(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: WelcomeFooterWidget(),
          )
        ],
      ),
    );
  }
}
BuildContext? context1;
/// 底部内容
class WelcomeFooterWidget extends StatelessWidget {
  const WelcomeFooterWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context1 = context;
    return Stack(
      children: [
        Positioned(
          // top: MediaQuery.of(context).padding.top,
          // right: (MediaQuery.of(context).size.width-300)/2,
          child: _homeBack(),
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
        Container(
          child: Column(
            children: [
              SizedBox(height: 595),
              GradientBtnWidget(
                width: 195,
                onTap: () {
                  Navigator.push(context1!, MaterialPageRoute(
                    builder: (context) {
                      return SignUpPage();
                    },
                  ));
                },
                child: BtnTextWhiteWidget(
                  text: 'Sign up',
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                child: LoginBtnWidget(),
                onTap: () {
                  Navigator.push(context1!, MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ));
                },
              ),
              SizedBox(height: 16),
              // Text(
              //   'Forgot password?',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w200,
              //     color: Colors.white,
              //   ),
              // ),
              SizedBox(height: 52),
              Row(
                children: [
                  Spacer(),
                  LineWidget(),
                  // LoginTypeIconWidget(icon: 'assets/icons/QQ.png'),
                  // LoginTypeIconWidget(icon: 'assets/icons/wechat.png'),
                  // LoginTypeIconWidget(icon: 'assets/icons/webo.png'),
                  LineWidget(),
                  Spacer(),
                ],
              ),
              // 底部安全距离
              SafeArea(
                top: false,
                child: SizedBox(height: 8),
              ),
            ],
          ),
        )
      ],
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
            right: (MediaQuery.of(context1!).size.width - 300) / 2,
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
            width: MediaQuery.of(context1!).size.width,
            height: MediaQuery.of(context1!).size.height,
          ),
        ],
      ),
    );
  }

  Widget _homeBack() {
    return Container(
      width: MediaQuery.of(context1!).size.width,
      height: MediaQuery.of(context1!).size.height,
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
            height: MediaQuery.of(context1!).size.height,
          )
        ],
      ),
    );
  }

}
