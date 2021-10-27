import 'package:flutter/material.dart';
import 'package:muse/theme/app_style.dart';
import 'package:muse/show/widgets/sign_widget.dart';
import 'package:muse/show/app_size_extension.dart';

/// 登录页面
class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
BuildContext? context1;
class _SignUpPageState extends State<SignUpPage> {
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
                clipper: SignClipper(),
                child: SignBodyWidget(),
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

/// 登录页面内容体
class SignBodyWidget extends StatelessWidget {
  const SignBodyWidget({
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
            'Sign up',
            style: kTitleTextStyle,
          ),
          SizedBox(height: 20.spH()),
          Text(
            'Your Username',
            style: kBodyTextStyle,
          ),
          SizedBox(height: 4.spH()),
          SignInput(
            hintText: 'Username',
            prefixIcon: 'assets/icons/user.png',
          ),
          SizedBox(height: 16.spH()),
          Text(
            'Your Password',
            style: kBodyTextStyle,
          ),
          SizedBox(height: 4.spH()),
          SignInput(
            hintText: 'Password',
            prefixIcon: 'assets/icons/pwd.png',
            obscureText: true,
          ),
          SizedBox(height: 32.spH()),
          SignBtnIconWidget(),
          SizedBox(height: 32.spH()),
        ],
      ),
    );
  }
}
