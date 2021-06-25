import 'package:muse/app_theme.dart';
import 'package:muse/custom_drawer/drawer_user_controller.dart';
import 'package:muse/custom_drawer/home_drawer.dart';
// import 'package:best_flutter_ui_templates/feedback_screen.dart';
// import 'package:best_flutter_ui_templates/help_screen.dart';
// import 'package:best_flutter_ui_templates/home_screen.dart';
// import 'package:best_flutter_ui_templates/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:muse/fitness_app/training/idea_list_screen.dart';
import 'package:muse/fitness_app/training/training_screen.dart';
// import 'package:muse/page/idea_page.dart';


import 'fitness_app/my_diary/my_diary_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

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
    // screenView = IdeaPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            screenView: screenView, drawerIsOpen: (bool ) {  },
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
      } else if (drawerIndex == DrawerIndex.Help) {
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
}
