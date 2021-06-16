import 'package:flutter/material.dart';
import 'package:muse/theme/app_style.dart';
import 'package:muse/widgets/sign_widget.dart';
import 'package:muse/page/app_size_extension.dart';

/// 登录页面
class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bg_login_header.png',
              width: 375,
              height: 476,
              fit: BoxFit.fitWidth,
            ),
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
            prefixIcon: 'assets/icons/icon_email.png',
          ),
          SizedBox(height: 16.spH()),
          Text(
            'Your Password',
            style: kBodyTextStyle,
          ),
          SizedBox(height: 4.spH()),
          SignInput(
            hintText: 'Password',
            prefixIcon: 'assets/icons/icon_pwd.png',
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
