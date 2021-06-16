import 'package:flutter/material.dart';
import 'package:muse/page/app_size_extension.dart';
import 'package:muse/page/login_page.dart';
import 'package:muse/page/sign_up_page.dart';
import 'package:muse/theme/app_colors.dart';
import 'package:muse/widgets/welcome_widget.dart';

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

/// 底部内容
class WelcomeFooterWidget extends StatelessWidget {
  const WelcomeFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientBtnWidget(
          width: 208,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
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
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ));
          },
        ),
        SizedBox(height: 16),
        Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 18,
            color: kTextColor,
          ),
        ),
        SizedBox(height: 54),
        Row(
          children: [
            Spacer(),
            LineWidget(),
            LoginTypeIconWidget(icon: 'assets/icons/logo_ins.png'),
            LoginTypeIconWidget(icon: 'assets/icons/logo_fb.png'),
            LoginTypeIconWidget(icon: 'assets/icons/logo_twitter.png'),
            LineWidget(),
            Spacer(),
          ],
        ),
        // 底部安全距离
        SafeArea(
          top: false,
          child: SizedBox(height: 16),
        ),
      ],
    );
  }
}