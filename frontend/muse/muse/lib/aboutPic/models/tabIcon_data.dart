import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:muse/aboutPic/bottom_navigation_view/bottom_bar_view.dart';
class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/image/tab_1.png',
      selectedImagePath: 'assets/image/tab_1s.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/image/tab_2.png',
      selectedImagePath: 'assets/image/tab_2s.png',
      index: 1,
      isSelected: false,
    ),
    TabIconData(
      imagePath: 'assets/image/tab_3.png',
      selectedImagePath: 'assets/image/tab_3s.png',
      index: 2,
      isSelected: false,
    ),
    TabIconData(
      imagePath: 'assets/image/tab_4.png',
      selectedImagePath: 'assets/image/tab_4s.png',
      index: 3,
      isSelected: false,
    ),
  ];
}
