import 'package:muse/theme/app_theme.dart';
import 'package:muse/show/drawer_user_controller.dart';
import 'package:muse/show/idea_home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:muse/show/widgets/idea_list_screen.dart';
import 'package:muse/utils/storage_util.dart';



class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}
String usernamelo = '未登录';
class _NavigationHomeScreenState extends State<NavigationHomeScreen> with TickerProviderStateMixin{
  late Widget screenView;
  late Widget screenView1;
  late DrawerIndex drawerIndex;
  late AnimationController animationController;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    screenView = IdeaListScreen(animationController: animationController);
    getlocal();
    // screenView = IdeaPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getlocal();
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView, drawerIsOpen: (bool ) {  }, username: 'getname()',
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          // screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Cancellation) {
        setState(() {
          // screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          // screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          // screenView = InviteFriend();
        });
      } else {
        //do in your way......
      }
    }
  }

  String getname() {
    getlocal();
    return StorageUtil.getStringItem('username');
  }

  Future<void> getlocal() async {
    usernamelo=await StorageUtil.getStringItem('username');
    // print("rrrrrrrrrrrrrrrrrrrr"+usernamelo);
    if (usernamelo == null) {
      usernamelo = '未登录';
    }
  }
}
