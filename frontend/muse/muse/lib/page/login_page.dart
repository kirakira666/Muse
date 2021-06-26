import 'package:flutter/material.dart';
import 'package:muse/theme/app_style.dart';
import 'package:muse/widgets/login_widget.dart';
import 'package:muse/page/app_size_extension.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
BuildContext? context1;
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    context1 = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            // top: MediaQuery.of(context).padding.top,
            // right: (MediaQuery.of(context).size.width-300)/2,
            child: _homeBack(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top-300,
            // right: (MediaQuery.of(context).size.width-300)/2,
            child: _homePic(),
          ),
          Column(
            children: [
              Spacer(),
              ClipPath(
                clipper: LoginClipper(),
                child: LoginBodyWidget(),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
          Positioned(
            top: 64,
            left: 28,
            child: BackIcon(),
          )
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
            'images/star.GIF',
            fit: BoxFit.cover,
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context1!).size.height,
          )
        ],
      ),
    );
  }

}

/// 登录页面内容体
class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32.spW()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 86.spH()),
          Text(
            'Login',
            style: kTitleTextStyle,
          ),
          SizedBox(height: 20.spH()),
          Text(
            'Your Username',
            style: kBodyTextStyle,
          ),
          SizedBox(height: 4.spH()),
          LoginInput(
            hintText: 'Username',
            prefixIcon: 'assets/icons/user.png',
          ),
          SizedBox(height: 16.spH()),
          Text(
            'Your Password',
            style: kBodyTextStyle,
          ),
          SizedBox(height: 4.spH()),
          LoginInput(
            hintText: 'Password',
            prefixIcon: 'assets/icons/pwd.png',
            obscureText: true,
          ),
          SizedBox(height: 32.spH()),
          LoginBtnIconWidget(),
          SizedBox(height: 32.spH()),
        ],
      ),
    );
  }
}
