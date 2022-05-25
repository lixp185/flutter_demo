import 'package:flutter/material.dart';
import 'package:flutter_demo/common/my_colors.dart';

enum BorderType {
  underLine, // 下划线
  outLine // 矩形边框
}

/// 通用表单编辑输入框
class FormEdit extends StatefulWidget {
  final TextEditingController? controller; // 控制器
  final Widget? prefixIcon; // 左边图标
  final Widget? suffixIcon; // 右边图标
  final TextInputType? inputType; //输入文本类型
  final TextInputAction? inputAction; // 键盘确定
  final ValueChanged<String>? onFieldSubmitted; // 键盘完成触发
  final TextStyle? textStyle; // 输入文本样式
  final int? maxLines; // 最大行数
  final int? maxLength; // 最大字数
  final int? minLength; // 最小字数
  final ValueChanged<String>? onChanged; // 输入回调
  final String? helperText; // 帮助文本
  final String? hintText; // hint文本
  final String? labelText; // 辅助标签文本
  final String? counterText; // 右下角计数字符
  final double? fontSize;
  final bool? enabled;
  final bool? readOnly;
  final bool? obscureText; // 是否隐藏输入内容
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextDirection? textDirection; // 文本输入方向
  final Function(bool)? listener;
  final double? height;
  final FocusNode? focusNode;
  final bool? autofocus;

  final BorderType borderType;
  final EdgeInsetsGeometry? contentPadding; // 内容边距

  const FormEdit({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.inputType,
    this.textStyle,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.helperText,
    this.hintText,
    this.fontSize,
    this.inputAction,
    this.validator,
    this.labelText,
    this.counterText,
    this.enabled,
    this.suffixIcon,
    this.obscureText,
    this.margin,
    this.minLength,
    this.textDirection,
    this.padding,
    this.readOnly,
    this.listener,
    this.height,
    this.focusNode,
    this.autofocus,
    this.onFieldSubmitted,
    this.borderType = BorderType.underLine,
    this.contentPadding,
  }) : super(key: key);

  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // focusNode.addListener(() {
    //   if (widget.listener != null) {
    //     widget.listener!(focusNode.hasFocus);
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    focusNode.unfocus(); // 取消焦点
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.unfocus(); // 取消焦点
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder enabledBorder;
    final InputBorder focusedBorder;
    if (widget.borderType == BorderType.underLine) {
      enabledBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: MyColors.color_d7d7d7, width: 0.5),
      );
      focusedBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: MyColors.color_f7605c, width: 0.5),
      );
    } else if (widget.borderType == BorderType.outLine) {
      enabledBorder = OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.color_d7d7d7, width: 0.5),
      );
      focusedBorder = OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.color_f7605c, width: 0.5),
      );
    } else {
      enabledBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: MyColors.color_d7d7d7, width: 0.5),
      );
      focusedBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: MyColors.color_f7605c, width: 0.5),
      );
    }
    return Container(
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      child: TextFormField(
        maxLines: widget.maxLines,
        textDirection: widget.textDirection,
        enabled: widget.enabled,
        readOnly: widget.readOnly ?? false,
        controller: widget.controller,
        keyboardType: widget.inputType,
        textInputAction: widget.inputAction ?? TextInputAction.next,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: widget.textStyle ??
            TextStyle(
                fontSize: widget.fontSize ?? 14, color: MyColors.white),
        cursorWidth: 1,
        cursorColor: MyColors.color_f7605c,
        maxLength: widget.maxLength,

        // 文本方向
        textAlign: TextAlign.start,
        // 自动获取焦点
        autofocus: widget.autofocus ?? false,
        // 隐藏输入文本 密码输入
        obscureText: widget.obscureText ?? false,
        // 自动校验
        autocorrect: true,
        // 文本输入回调
        onChanged: widget.onChanged,
        // 焦点控制
        focusNode: widget.focusNode ?? focusNode,

        // 装饰器
        decoration: InputDecoration(
          counterText: widget.counterText ?? "",
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintTextDirection: TextDirection.ltr,
          //解决左侧图标与正文间距问题
          prefixIconConstraints: const BoxConstraints(),
          contentPadding: widget.contentPadding,
          prefixIcon: widget.prefixIcon != null
              ? Container(
                  margin: EdgeInsetsDirectional.only(end: 10),
                  child: widget.prefixIcon,
                )
              : null,
          // 右侧图标
          suffixIcon: widget.suffixIcon,
          suffixIconConstraints: const BoxConstraints(),
          hintStyle: TextStyle(
              color: MyColors.color_999999, fontSize: widget.fontSize ?? 14),
          // 默认边框颜色
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          border: enabledBorder,
          isDense: true,
        ),
        validator: widget.validator,
      ),
    );
  }
}
