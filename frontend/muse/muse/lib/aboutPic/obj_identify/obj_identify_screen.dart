import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;


import 'package:muse/aboutPic/color_picker_pic/water_view.dart';

import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;
const String mobile = "MobileNet";
const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";
const String deeplab = "DeepLab";
const String posenet = "PoseNet";
CloudBaseCore core = CloudBaseCore.init({
  // 填写您的云开发 env
  'env': 'zhuji-cloudbase-3g9902drd47633ab',
  // 填写您的移动应用安全来源凭证
  // 生成凭证的应用标识必须是 Android 包名或者 iOS BundleID
  'appAccess': {
    // 凭证
    'key': 'e6f33326a0d40fecfc67ffc2877255bc',
    // 版本
    'version': '1'
  },
  // 请求超时时间（选填）
  'timeout': 3000
});
CloudBaseAuth auth = CloudBaseAuth(core);
CloudBaseDatabase db = CloudBaseDatabase(core);
List random = [];
List<String> images = [
  "images/1.gif",
  "images/1.gif",
  "images/1.gif",
  "images/1.gif",
  "images/1.gif"
];

List<String> title = ["1", "2", "3", "4", "5"];

class ObjIdentifyScreen extends StatefulWidget {
  const ObjIdentifyScreen({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController animationController;

  @override
  _ObjIdentifyScreenState createState() => new _ObjIdentifyScreenState();
}

class _ObjIdentifyScreenState extends State<ObjIdentifyScreen>
    with TickerProviderStateMixin {
  late File? _image = null;
  late List _recognitions = [];
  String _model = yolo;

  late double _imageHeight = 200;
  late double _imageWidth = 200;
  bool _busy = false;
  late Animation<double> topBarAnimation;

  Future<void> objImg(String nn) async {
    CloudBaseAuthState authState = await auth.getAuthState();

    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        // 登录成功
        print('注册成功');
      }).catchError((err) {
        // 登录失败
        print('注册失败');
      });
    } else {
      print('jnkfj');
    }
    var a = Random().nextInt(18744);
    var _ = db.command;
    if (nn == 'person') {
      db.collection('face').limit(5).get().then((res) {
        random = res.data;
        print(res);
      });
    } else {
      db.collection('item').limit(1).where({'itemName': nn}).get().then((res) {
            // random = res.data;
            print(res);
            List lll = res.data[0]['url'];
            List re = [];
            for(int i =0;i<lll.length;++i){
              var a={
                'workName':nn,
                'picUrl': lll[i]
              };
              re.add(a);
            }
            random = re;
          });
    }
  }

  Future predictImagePicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    predictImage(image);
  }

  Future predictImage(File image) async {
    if (image == null) return;

    switch (_model) {
      case yolo:
        await yolov2Tiny(image);
        break;
      // case ssd:
      //   await ssdMobileNet(image);
      //   break;
      // case deeplab:
      //   await segmentMobileNet(image);
      //   break;
      // case posenet:
      //   await poseNet(image);
      //   break;
      default:
        await recognizeImage(image);
      // await recognizeImageBinary(image);
    }

    new FileImage(image)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageHeight = info.image.height.toDouble();
        _imageWidth = info.image.width.toDouble();
      });
    }));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    super.initState();

    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String res;
      switch (_model) {
        case yolo:
          res = (await Tflite.loadModel(
            model: "assets/yolov2_tiny.tflite",
            labels: "assets/yolov2_tiny.txt",
            // useGpuDelegate: true,
          ))!;
          break;
        // case ssd:
        //   res = (await Tflite.loadModel(
        //     model: "assets/ssd_mobilenet.tflite",
        //     labels: "assets/ssd_mobilenet.txt",
        //     // useGpuDelegate: true,
        //   ))!;
        //   break;
        // case deeplab:
        //   res = (await Tflite.loadModel(
        //     model: "assets/deeplabv3_257_mv_gpu.tflite",
        //     labels: "assets/deeplabv3_257_mv_gpu.txt",
        //     // useGpuDelegate: true,
        //   ))!;
        //   break;
        // case posenet:
        //   res = (await Tflite.loadModel(
        //     model: "assets/posenet_mv1_075_float_from_checkpoints.tflite",
        //     // useGpuDelegate: true,
        //   ))!;
        //   break;
        default:
          res = (await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt",
            // useGpuDelegate: true,
          ))!;
      }
      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Future recognizeImage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions!;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  Future recognizeImageBinary(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var imageBytes = (await rootBundle.load(image.path)).buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image resizedImage = img.copyResize(oriImage, height: 224, width: 224);
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),
      numResults: 6,
      threshold: 0.05,
    );
    setState(() {
      _recognitions = recognitions!;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  Future yolov2Tiny(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.detectObjectOnImage(
      path: image.path,
      model: "YOLO",
      threshold: 0.3,
      imageMean: 0.0,
      imageStd: 255.0,
      numResultsPerClass: 1,
    );
    // var imageBytes = (await rootBundle.load(image.path)).buffer;
    // img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    // img.Image resizedImage = img.copyResize(oriImage, 416, 416);
    // var recognitions = await Tflite.detectObjectOnBinary(
    //   binary: imageToByteListFloat32(resizedImage, 416, 0.0, 255.0),
    //   model: "YOLO",
    //   threshold: 0.3,
    //   numResultsPerClass: 1,
    // );
    setState(() {
      print(recognitions![0]['detectedClass']);
      String x = recognitions![0]['detectedClass'];
      objImg(x);
      _recognitions = recognitions!;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  Future ssdMobileNet(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.detectObjectOnImage(
      path: image.path,
      numResultsPerClass: 1,
    );
    // var imageBytes = (await rootBundle.load(image.path)).buffer;
    // img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    // img.Image resizedImage = img.copyResize(oriImage, 300, 300);
    // var recognitions = await Tflite.detectObjectOnBinary(
    //   binary: imageToByteListUint8(resizedImage, 300),
    //   numResultsPerClass: 1,
    // );
    setState(() {
      _recognitions = recognitions!;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  Future segmentMobileNet(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runSegmentationOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _recognitions = recognitions!;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}");
  }

  Future poseNet(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runPoseNetOnImage(
      path: image.path,
      numResults: 2,
    );

    print(recognitions);

    setState(() {
      _recognitions = recognitions!;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  onSelect(model) async {
    setState(() {
      _busy = true;
      _model = model;
      _recognitions = [];
    });
    await loadModel();

    if (_image != null) {
      predictImage(_image!);
    } else
      setState(() {
        _busy = false;
      });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];

    double factorX = _imageWidth / _imageHeight * 240;
    double factorY = 240;
    Color blue = Color.fromRGBO(37, 213, 253, 1.0);
    return _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX +
            (screen.width - 240 * (_imageWidth / _imageHeight)) / 2,
        top: re["rect"]["y"] * factorY + 110,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: blue,
              width: 2,
            ),
          ),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> renderKeypoints(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageWidth * screen.width;

    var lists = <Widget>[];
    _recognitions.forEach((re) {
      var color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
      var list = re["keypoints"].values.map<Widget>((k) {
        return Positioned(
          left: k["x"] * factorX - 6,
          top: k["y"] * factorY - 6,
          width: 100,
          height: 12,
          child: Text(
            "● ${k["part"]}",
            style: TextStyle(
              color: color,
              fontSize: 12.0,
            ),
          ),
        );
      }).toList();

      lists..addAll(list);
    });

    return lists;
  }

  var currentPage = random.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: random.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];
    stackChildren.add(Positioned(
      // top: MediaQuery.of(context).padding.top,
      // right: (MediaQuery.of(context).size.width-300)/2,
      child: _homeBack(),
    ));
    // stackChildren.add(Positioned(
    //   top: 0.0,
    //   left: 0.0,
    //   width: size.width,
    //   child: WaterView(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //             parent: widget.animationController,
    //             curve: Interval((1 / 9) * 7, 1.0,
    //                 curve: Curves.fastOutSlowIn))),
    //     mainScreenAnimationController: widget.animationController, valuePer: 35.0,
    //   ),
    // ));
    if (_model == deeplab && _recognitions != null) {
      stackChildren.add(Positioned(
        top: 110.0,
        left: 0.0,
        width: size.width,
        child: _image == null
            ? Text('No imaged.')
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: MemoryImage(_recognitions as Uint8List),
                        fit: BoxFit.fill)),
                child: Opacity(opacity: 0.3, child: Image.file(_image!))),
      ));
    } else {
      // stackChildren.add(Positioned(
      //   top: 0.0,
      //   left: 0.0,
      //   width: size.width,
      //   child: _image == null ? Text('No image selected.') : Image.file(_image!),
      // ));
      stackChildren.add(Positioned(
        top: 100.0,
        left: (size.width - 240 * (_imageWidth / _imageHeight)) / 2,
        height: 240,
        child:
            _image == null ? Image.asset('images/1.gif') : Image.file(_image!),
      ));
    }

    if (_model == mobile) {
      stackChildren.add(Center(
        child: Column(
          children: _recognitions != null
              ? _recognitions.map((res) {
                  return Text(
                    "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      background: Paint()..color = Colors.white,
                    ),
                  );
                }).toList()
              : [],
        ),
      ));
    } else if (_model == ssd || _model == yolo) {
      stackChildren.addAll(renderBoxes(size));
    } else if (_model == posenet) {
      stackChildren.addAll(renderKeypoints(size));
    }

    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    stackChildren.add(SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Art Items!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46.0,
                      fontFamily: "Calibre-Semibold",
                      letterSpacing: 1.0,
                    )),
                SizedBox(
                  height: 40,
                  child: IconButton(
                    icon: Icon(
                      Icons.add_box,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      predictImagePicker();
                      print('照片');
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 180,
          ),
          SizedBox(
            height: 70,
          ),

          Stack(
            children: <Widget>[
              CardScrollWidget(currentPage),
              Positioned.fill(
                child: PageView.builder(
                  itemCount: random.length,
                  controller: controller,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ),
              )
            ],
          ),

          // WaterView(
          //   mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          //       CurvedAnimation(
          //           parent: widget.animationController,
          //           curve: Interval((1 / 9) * 7, 1.0,
          //               curve: Curves.fastOutSlowIn))),
          //   mainScreenAnimationController: widget.animationController, valuePer: ddvalue(currentPage),
          // ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    ));
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        body: Stack(
          children: stackChildren,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: predictImagePicker,
          tooltip: 'Pick Image',
          child: Icon(Icons.image),
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(
            FloatingActionButtonLocation.endFloat, 0, -50),
      ),
    );
  }

  Widget _homeBack() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
            height: MediaQuery.of(context).size.height,
          )
        ],
      ),
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = [];

        for (var i = 0; i < random.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(random[i]['picUrl'], fit: BoxFit.cover),
                      // Image.asset(images[i], fit: BoxFit.cover),
                      // image:NetworkImage('https://7a68-zhuji-cloudbase-3g9902drd47633ab-1305329525.tcb.qcloud.la/'+picUrl),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(random[i]['workName'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text('About '+random[i]['workName'],
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }

  String ll(i) {
    if (i == 1) {
      return '1st';
    } else if (i == 2) {
      return '2nd';
    } else if (i == 3) {
      return '3rd';
    }
    return i.toString() + 'th';
  }
}
