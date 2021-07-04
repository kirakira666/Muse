import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

typedef SelectColor = Color Function(Color color);

class ColorPickView extends StatefulWidget {
  Size size;
  double selectRadius;
  double padding;
  Color selectColor;
  Color selectRingColor;
  final SelectColor selectColorCallBack;

  ColorPickView(
      {required this.size,
        required this.selectColorCallBack,
        required this.selectRadius,
        required this.padding,
        required this.selectRingColor,
        required this.selectColor}) {
    assert(size == null || (size != null && size.height == size.width),
    '控件宽高必须相等');
  }

  @override
  State<StatefulWidget> createState() {
    return ColorPickState();
  }
}

class ColorPickState extends State<ColorPickView> {
  late double radius;
  Color currentColor = Color(0xff00ff);
  late Offset currentOffset;
  late Offset topLeftPosition = Offset(0, 0);
  late Offset selectPosition = Offset(0, 0);
  late Size screenSize;
  GlobalKey globalKey = GlobalKey();
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    // screenSize = MediaQuery.of(context).size;
    screenSize = widget.size;
    widget.selectRadius = 10;
    widget.padding = 80;
    widget.selectRingColor = Colors.black;
    assert(
    widget.size == null ||
        (widget.size != null && screenSize.width >= widget.size.width),
    '控件宽度太宽');
    radius = widget.size.width / 2 - widget.padding;
    currentOffset = Offset(radius, radius);
    if (widget.selectColor != null && selectPosition == null)
      _setColor(widget.selectColor);
    _initLeftTop();
    return GestureDetector(
      key: globalKey,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: widget.size.width,
              height: widget.size.width,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CustomPaint(
                    painter: ColorPick(radius: radius),
                    size: widget.size,
                  ),
                  Positioned(
                    left: isTap
                        ? currentOffset.dx -
                        (topLeftPosition == Offset(0, 0) ? 0 : (topLeftPosition.dx+widget.selectRadius/2))
                        : (selectPosition == Offset(0, 0) ? radius : selectPosition.dx+widget.selectRadius/2),
                    top: isTap
                        ? currentOffset.dy -
                        (topLeftPosition == Offset(0, 0) ? 0 : (topLeftPosition.dy+widget.selectRadius/2))
                        : (selectPosition == Offset(0, 0) ? radius : selectPosition.dy+widget.selectRadius/2),
                    //这里减去80，是因为上下边距各40 所以需要减去还有半径
                    child: Container(
                      width: widget.selectRadius,
                      height: widget.selectRadius,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.selectRadius),
                        border: Border.fromBorderSide(
                            BorderSide(color: widget.selectRingColor)),
                      ),
                      child: ClipOval(
                        child: Container(
                          color: currentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),
          Positioned(
            top: MediaQuery.of(context).padding.top+80,
            left: (MediaQuery.of(context).size.width-100)/2-10,
            child: Container(
              color: currentColor,
              height: 20,
              width: 20,
              child: SizedBox(),
            ),
          ),

        ],
      ),

      onTapDown: (e) {
        setState(() {
          isTap = true;
          _initLeftTop();
          if (!isOutSide(e.globalPosition.dx, e.globalPosition.dy)) {
            currentColor =
                getColorAtPoint(e.globalPosition.dx, e.globalPosition.dy);
            currentOffset = e.globalPosition;
            if (widget.selectColorCallBack != null) {
              widget.selectColorCallBack(currentColor);
            }
          }
        });
      },
      onPanUpdate: (e) {
        isTap = true;
        _initLeftTop();
        setState(() {
          if (!isOutSide(e.globalPosition.dx, e.globalPosition.dy)) {
            currentOffset = e.globalPosition;
            currentColor =
                getColorAtPoint(e.globalPosition.dx, e.globalPosition.dy);
            if (widget.selectColorCallBack != null) {
              widget.selectColorCallBack(currentColor);
            }
          }
        });
      },
    );
  }

  void _initLeftTop() {
    if (globalKey.currentContext != null && topLeftPosition == null) {

      RenderObject? box = globalKey.currentContext!.findRenderObject();
      RenderBox bo = box as RenderBox;
      topLeftPosition = bo.localToGlobal(Offset.zero);
    }
  }

  bool isOutSide(double eventX, double eventY) {
    print(eventX);
    print(eventY);
    double x = eventX - (topLeftPosition.dx + radius + widget.padding);
    double y = eventY - (topLeftPosition.dy + radius + widget.padding);
    // print(x);
    // print(y);
    double r = sqrt(x * x + y * y);
    if (r >= radius) return true;
    return false;
  }

  void _setColor(Color color) {
    //设置颜色值
    var hsvColor = HSVColor.fromColor(color);
    double r = hsvColor.saturation * radius;
    double radian = hsvColor.hue / -180.0 * pi;
    _updateSelector(r * cos(radian), -r * sin(radian));
    currentColor = color;
  }

  void _updateSelector(double eventX, double eventY) {
    //更新选中颜色值
    eventY = eventY;
    double r = sqrt(eventX * eventX + eventY * eventY);
    double x = eventX, y = eventY;
    if (r > radius) {
      x *= radius / r;
      y *= radius / r;
    }
    selectPosition =
    new Offset(x + radius + widget.padding, y + radius + widget.padding);
  }

  Color getColorAtPoint(double eventX, double eventY) {
    //获取坐标在色盘中的颜色值
    eventY = eventY;
    double x = eventX - (topLeftPosition.dx + radius + widget.padding);
    double y = eventY - (topLeftPosition.dy + radius + widget.padding);
    double r = sqrt(x * x + y * y);
    List<double> hsv = [0.0, 0.0, 1.0];
    hsv[0] = (atan2(-y, -x) / pi * 180).toDouble() + 180;
    hsv[1] = max(0, min(1, (r / radius)));
    return HSVColor.fromAHSV(1.0, hsv[0], hsv[1], hsv[2]).toColor();
  }
}

class ColorPick extends CustomPainter {
  late Paint mPaint;
  late Paint saturationPaint;
  List<Color> mCircleColors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 0)
  ];
  final List<Color> mStatColors = [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(0, 255, 255, 255)
  ];
  late SweepGradient hueShader;
  late var radius;
  late RadialGradient saturationShader;

  ColorPick({this.radius}) {
    _init();
  }

  void _init() {
    //{Color.RED, Color.YELLOW, Color.GREEN, Color.CYAN, Color.BLUE, Color.MAGENTA, Color.RED}
    mPaint = new Paint();
    saturationPaint = new Paint();

    hueShader = new SweepGradient(colors: mCircleColors);
    saturationShader = new RadialGradient(colors: mStatColors);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    mPaint.shader = hueShader.createShader(rect);
    saturationPaint.shader = saturationShader.createShader(rect);
    // 注意这一句
    canvas.clipRect(rect);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, mPaint);
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius, saturationPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}