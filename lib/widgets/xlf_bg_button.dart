import 'package:flutter/material.dart';

///TextButton 背景样式
class XlfBgButton extends StatelessWidget {
  /// 按钮文本
  final String? text;

  /// 按钮点击事件
  final VoidCallback? onPressed;

  /// 长按事件
  final VoidCallback? onLongPress;

  /// 边距
  final EdgeInsetsGeometry? margin;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  final AlignmentGeometry? alignment;

  /// 按钮宽
  final double? width;

  /// 按钮高
  final double? height;

  /// 字体
  final double? fontSize;

  /// 是否可点击
  final bool isClick;

  /// 自定义按钮
  final Widget? child;

  /// 圆角
  final double? radius;

  /// 背景颜色
  final Color backgroundColor;

  /// 圆形按钮



   XlfBgButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.onLongPress,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.isClick = true,
    this.alignment,
    this.child,
    this.radius,
    this.padding,
    this.backgroundColor = const Color(0xffff6332),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        width: width ?? double.infinity,
        height: height,
        margin: margin ?? EdgeInsetsDirectional.only(start: 32, end: 32),
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(const Size(0, 0)),
              padding: MaterialStateProperty.all(padding ??
                  EdgeInsetsDirectional.only(top: 10, bottom: 10)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 4))),

              // shape: MaterialStateProperty.all(const StadiumBorder()),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return backgroundColor.withOpacity(0.8);
                } else if (states.contains(MaterialState.disabled)) {
                  return backgroundColor.withOpacity(0.32);
                }
                //默认不使用背景颜色
                return backgroundColor;
              })),
          onPressed: isClick ? onPressed : null,
          onLongPress: isClick ? onLongPress : null,
          child: child ??
              Text(
                text!,
               style: TextStyle(
                 color: Colors.white,
                 fontSize: fontSize,
               ),
              ),
        ));
  }
}
