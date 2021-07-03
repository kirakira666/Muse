import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:cloudbase_storage/cloudbase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/aboutPic/color_picker_pic/color_pick_screen.dart';
import 'package:muse/aboutPic/facing/encode_util.dart';
import 'package:muse/aboutPic/index_pic.dart';

import 'package:muse/storage_util.dart';
import 'package:muse/test.dart';
import 'package:muse/theme/app_size.dart';
import 'package:muse/theme/app_style.dart';
import 'package:image_picker/image_picker.dart';

class FaceScreen extends StatefulWidget {
  const FaceScreen({Key? key}) : super(key: key);

  @override
  _FaceScreenState createState() => _FaceScreenState();
}

class _FaceScreenState extends State<FaceScreen>{
  bool obscureText = false;
  String username = '';
  bool hhh = false;
  String pwd = '';
  var content = 'hhh';
  List _imageList = []; //图片列表
  int _photoIndex = 0; //选择拍照还是相册的索引
  List _actionSheet = [
    // {"name": "拍照", "icon": Icon(Icons.camera_alt)},
    {"name": "相册", "icon": Icon(Icons.photo)}
  ];

  late AnimationController animationController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hhhmj(),
    );
  }

  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
  }

  // _takePhoto() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     _imgPath = image;
  //   });
  // }
  //
  // /*相册*/
  // _openGallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _imgPath = image;
  //   });
  // }

  //图片列表的刻画
  List<Widget> _getImageList() {
    return _imageList.map((img) {
      print(img);
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Image.file(
              img,
              fit: BoxFit.cover,
              width: 100.0,
              height: 70.0,
            ),
            Positioned(
              right: 5.0,
              top: 5.0,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    color: Colors.lightBlue,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _imageList.remove(img);
                  });
                },
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  //获取sheet选择
  Future _getActionSheet() async {
    await showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _actionSheet.length,
              itemExtent: 50.0,
              itemBuilder: (innerCtx, i) {
                return ListTile(
                  title: Text(_actionSheet[i]["name"]),
                  leading: _actionSheet[i]["icon"],
                  onTap: () {
                    setState(() {
                      _photoIndex = 1;
                    });
                    _getImage();
                  },
                );
              },
            ),
          );
        });
  }

  Future _getImage() async {
    Navigator.of(context).pop();
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //没有选择图片或者没有拍照
    if (image != null) {
      setState(() {
        _imageList.add(image);
      });
    }
  }

  Future<void> faceSearch() async {

    print(_imageList[0].path);
    EncodeUtil.image2Base64(_imageList[0].path).then((data){
      String imageBase64=data;
      // print(imageBase64);
      var client = new http.Client();
      var time = new DateTime.now().millisecondsSinceEpoch;
      int a = 5;
      client.post(
          'https://api-cn.faceplusplus.com/facepp/v3/search',
          body: {
            "api_key":"3tWnsEAOU1dL9PlOh40PV3p2LdVDZEhG",
            "api_secret": "VWtztt1p8Alss_PZNIHuH5xUrJWi59b7",
            "image_base64": imageBase64,
            "outer_id": "artworkFaceKira666",
            'return_result_count': '5'
          }
      ).then((response){
        print(response.body);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => IndexPic(),
        //     ));
      },onError: (error){
        print(error);
      }).whenComplete(
          client.close
      );
    });
  }

  Widget hhhmj() {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: 'hintText',
            border: kInputBorder,
            focusedBorder: kInputBorder,
            enabledBorder: kInputBorder,
            prefixIcon: Container(
              width: kIconBoxSize,
              height: kIconBoxSize,
              alignment: Alignment.center,
            ),
          ),
          obscuringCharacter: '*',
          obscureText: obscureText,
          style: kBodyTextStyle.copyWith(
            fontSize: 18,
          ),
          onChanged: (text) {
            if (obscureText) {
              print('pwd,' + text);
              content = text;
            } else {
              content = text;
              print('ema,' + text);
            }
          },
        ),
        RaisedButton(
          child: Text("拍照"),
          onPressed: () => _getActionSheet(),
        ),
        RaisedButton(
          child: Text("提交"),
          onPressed: () => {faceSearch()},
        ),
        Text("----照片列表----"),
        _imageList.isNotEmpty
            ? Wrap(
          spacing: 10.0,
          children: _getImageList(),
        )
            : Text("暂无内容")
      ],
    );
  }

}
