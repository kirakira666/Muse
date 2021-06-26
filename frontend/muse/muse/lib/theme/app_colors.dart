import 'package:flutter/widgets.dart';

// 背景颜色
const Color kBgColor = Color(0xFFFEDCE0);
// 文字颜色
const Color kTextColor = Color(0xFF282457);
// 按钮开始颜色
const Color kBtnColorStart = Color(0xFF1F003D);
// 按钮结束颜色
const Color kBtnColorEnd = Color(0xFF3F569A);
// 按钮投影颜色
const Color kBtnShadowColor = Color(0x333160D8);
// 输入框边框颜色
const Color kInputBorderColor = Color(0xFFECECEC);

// 按钮渐变背景色
const LinearGradient kBtnLinearGradient = LinearGradient(
  colors: [
    kBtnColorStart,
    kBtnColorEnd,
  ],
);
