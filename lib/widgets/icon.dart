import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class IconWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IconState();
  }
}

class _IconState extends State<IconWidgetDemo> {
  var _storageDir;

  @override
  void initState() {
    super.initState();
    _storageDir = getExternalStorageDirectory().then((value) => value?.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [Text("内置图标："), Icon(Icons.info)],
          ),
          Row(
            children: [Text("内置图标红色："), Icon(Icons.info,color: Colors.red,)],
          ),
          Row(
            children: [
              Text("资源图片(images/)："),
              Image.asset(
                "images/icon_vip_fk.png",
                width: 50,
                height: 50,
              )
            ],
          ),
          Column(
            children: [
              Text("网络图片："),
              Image.network(
                "https://bimg.instrument.com.cn/g/sh100000/app/index_ad_20170327_1.jpg",
                // color: Colors.blue,
                // colorBlendMode: BlendMode.colorDodge,
              )
            ],
          ),

          Row(
            children: [
              Text("sd卡图片："),
              Image.file(
                File("/storage/emulated/0/user_share_1.png"),
                width: 100,
                height: 100,
              )
            ],
          ),
          Column(
            children: [
              Text("图片缩放："),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Image.network(
                      "https://bimg.instrument.com.cn/g/sh100000/app/index_ad_20170327_1.jpg",
                      fit: BoxFit.fitWidth,
                      // color: Colors.blue,
                      // colorBlendMode: BlendMode.colorDodge,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Image.network(
                      "https://bimg.instrument.com.cn/g/sh100000/app/index_ad_20170327_1.jpg",
                      fit: BoxFit.cover,
                      // color: Colors.blue,
                      // colorBlendMode: BlendMode.colorDodge,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Image.network(
                      "https://bimg.instrument.com.cn/g/sh100000/app/index_ad_20170327_1.jpg",
                      fit: BoxFit.fill,
                      // color: Colors.blue,
                      // colorBlendMode: BlendMode.colorDodge,
                    ),
                  ),
                ],
              )

            ],
          ),
        ],
      ),
    );
  }
}

/// const Image({
/// ...
///   this.width, //图片的宽
///   this.height, //图片高度
///   this.color, //	图片的前景色，一般不设置或设置透明色，会覆盖掉图片，一般会和colorBlendMode结合使用
///   this.colorBlendMode, //一般和color结合使用，设置color的混合模式
///   this.fit,//缩放模式
/// BoxFit.fill:全图显示，图片会被拉伸，并充满父容器。
/// BoxFit.contain:全图显示，显示原比例，可能会有空隙。
/// BoxFit.cover：显示可能拉伸，可能裁切，充满（图片要充满整个容器，还不变形）。
/// BoxFit.fitWidth：宽度充满（横向充满），显示可能拉伸，可能裁切。
/// BoxFit.fitHeight ：高度充满（竖向充满）,显示可能拉伸，可能裁切。
/// BoxFit.scaleDown：效果和contain差不多，但是此属性不允许显示超过源图片大小，可小不可大。

///   this.alignment = Alignment.center, //对齐方式
///   this.repeat = ImageRepeat.noRepeat, //重复方式
///   ...
/// })
