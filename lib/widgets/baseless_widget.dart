
import 'package:flutter/material.dart';

// 静态页面基类
abstract class BaseStatelessWidget extends StatelessWidget{

  //构造
  const BaseStatelessWidget({Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return initDefaultBuild(context);
  }

  //构建界面 init
  Widget initDefaultBuild(BuildContext context);

}