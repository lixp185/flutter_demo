import 'package:flutter/material.dart';

class TextFieldWidgetDemo extends StatefulWidget {
  const TextFieldWidgetDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TextFieldState();
  }
}

class _TextFieldState extends State<TextFieldWidgetDemo> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      var text = _controller.text;
      var selection = _controller.selection;
      print("addListener text $text ");
      print("addListener selection $selection ");
    });
    _controller.removeListener(() {
      var text = _controller.text;

      print("removeListener $text");
    });
  }

  /// Returns true if the given String is a valid email address.
  bool isValidEmail(String text) {
    return RegExp(
      r'(?<name>[a-zA-Z0-9]+)'
      r'@'
      r'(?<domain>[a-zA-Z0-9]+)'
      r'.'
      r'(?<topLevelDomain>[a-zA-Z0-9]+)',
    ).hasMatch(text);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              cursorColor: Colors.blue,
              controller: _controller,
              autocorrect: true,
              onChanged: (text) {
                print("onChanged:$text");
              },
              contextMenuBuilder: (c, s) {
                final TextEditingValue value = s.textEditingValue;
                final List<ContextMenuButtonItem> buttonItems =
                    s.contextMenuButtonItems;
                String textInside = value.selection.textInside(value.text);
                if (isValidEmail(textInside)) {
                  buttonItems.add(ContextMenuButtonItem(
                      onPressed: () {}, label: 'send email'));
                }

                return AdaptiveTextSelectionToolbar.buttonItems(
                    buttonItems: buttonItems, anchors: s.contextMenuAnchors);
              },
              decoration: InputDecoration(
                  labelText: "关键字",
                  hintText: "请输入内容",
                  suffixIcon: InkWell(
                    child: const Icon(Icons.close),
                    onTap: () {
                      _controller.clear();
                    },
                  ),
                  // icon: Icon(Icons.add),
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("搜索")),

          ],
        ),
      ),
    );
  }
}

///const TextField({
///     Key key,
///     this.controller,                    // 控制正在编辑文本
///     this.focusNode,                     // 获取键盘焦点
///     this.decoration = const InputDecoration(),              // 边框装饰
///     TextInputType keyboardType,         // 键盘类型
///     this.textInputAction,               // 键盘的操作按钮类型
///     this.textCapitalization = TextCapitalization.none,      // 配置大小写键盘
///     this.style,                         // 输入文本样式
///     this.textAlign = TextAlign.start,   // 对齐方式
///     this.textDirection,                 // 文本方向
///     this.autofocus = false,             // 是否自动对焦
///     this.obscureText = false,           // 是否隐藏内容，例如密码格式
///     this.autocorrect = true,            // 是否自动校正
///     this.maxLines = 1,                  // 最大行数
///     this.maxLength,                     // 允许输入的最大长度
///     this.maxLengthEnforced = true,      // 是否允许超过输入最大长度
///     this.onChanged,                     // 文本内容变更时回调
///     this.onEditingComplete,             // 提交内容时回调
///     this.onSubmitted,                   // 用户提示完成时回调
///     this.inputFormatters,               // 验证及格式
///     this.enabled,                       // 是否不可点击
///     this.cursorWidth = 2.0,             // 光标宽度
///     this.cursorRadius,                  // 光标圆角弧度
///     this.cursorColor,                   // 光标颜色
///     this.keyboardAppearance,            // 键盘亮度
///     this.scrollPadding = const EdgeInsets.all(20.0),        // 滚动到视图中时，填充边距
///     this.enableInteractiveSelection,    // 长按是否展示【剪切/复制/粘贴菜单LengthLimitingTextInputFormatter】
///     this.onTap,                         // 点击时回调
/// })

/// return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               cursorColor: Colors.blue,
//               cursorWidth: 1,
//               cursorRadius: Radius.zero,
//               controller: TextEditingController(
//                 text: "123456789",
//               ),
//               focusNode: FocusNode(),
//               style: TextStyle(fontSize: 14),
//               textAlign: TextAlign.left,
//               autocorrect: true,
//               onSubmitted: (v) {},
//               maxLength: 11,
//               inputFormatters: [],
//               decoration: InputDecoration(
//                   labelText: "电话",
//                   hintText: "请输入电话",
//                   prefixIcon: Icon(Icons.phone),
//                   // icon: Icon(Icons.add),
//                   hintStyle: TextStyle(color: Colors.teal)),
//               textInputAction: TextInputAction.search,
//               keyboardType: TextInputType.phone,
//             ),
//             TextField(
//               cursorColor: Colors.blue,
//               cursorWidth: 1,
//               cursorRadius: Radius.zero,
//               controller: TextEditingController(),
//               style: TextStyle(fontSize: 14),
//               textAlign: TextAlign.left,
//               autocorrect: true,
//               obscureText: true,
//               onSubmitted: (v) {},
//               onChanged: (text){
//
//
//               },
//               inputFormatters: [],
//               decoration: InputDecoration(
//                   labelText: "密码",
//                   hintText: "请输入密码",
//                   prefixIcon: Icon(Icons.lock),
//                   // icon: Icon(Icons.add),
//                   hintStyle: TextStyle(color: Colors.grey)),
//               textInputAction: TextInputAction.search,
//               keyboardType: TextInputType.text,
//             ),
//             Text("表单form"),
//             Form(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.disabled,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       autofocus: true,
//                       cursorWidth: 1,
//                       controller: _phoneController,
//                       style: TextStyle(fontSize: 14),
//                       textAlign: TextAlign.left,
//                       autocorrect: true,
//                       maxLength: 11,
//                       inputFormatters: [],
//                       onChanged: (text){
//                         print("onChanged:$text");
//                       },
//                       decoration: InputDecoration(
//                           labelText: "电话",
//                           hintText: "请输入电话",
//                           prefixIcon: Icon(Icons.phone),
//                           // icon: Icon(Icons.add),
//                           hintStyle: TextStyle(color: Colors.grey)),
//                       textInputAction: TextInputAction.search,
//                       keyboardType: TextInputType.phone,
//                       validator: (phone) {
//                         return phone?.length == 11 ? null : "请输入11位手机号码";
//                       },
//                     ),
//                     TextFormField(
//                       cursorColor: Colors.blue,
//                       cursorWidth: 1,
//                       cursorRadius: Radius.zero,
//                       controller: TextEditingController(),
//                       style: TextStyle(fontSize: 14),
//                       textAlign: TextAlign.left,
//                       autocorrect: true,
//                       obscureText: true,
//                       inputFormatters: [],
//                       decoration: InputDecoration(
//                           labelText: "密码",
//                           hintText: "请输入密码",
//                           prefixIcon: Icon(Icons.lock),
//                           hintStyle: TextStyle(color: Colors.grey)),
//                       textInputAction: TextInputAction.search,
//                       keyboardType: TextInputType.text,
//                       validator: (psd) {
//                         return psd != null && psd.length >= 6
//                             ? null
//                             : "密码至少6位数";
//                       },
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           _phoneController.text = "123";
//                           _phoneController.text = "1234";
//                           if ((_formKey.currentState as FormState).validate()) {
//                             // 验证通过
//                           } else {
//                             print("验证不通过---${_phoneController.value.text}");
//                             // 验证不通过
//                           }
//                         },
//                         child: Text("提交")),
//                   ],
//                 )),
//             FormEdit(
//                 margin: EdgeInsetsDirectional.only(top: 15),
//                 contentPadding: EdgeInsetsDirectional.only(
//                     start: 13, end: 0, top: 12, bottom: 12),
//                 borderType: BorderType.outLine,
//                 inputType: TextInputType.text,
//                 fontSize: 14,
//                 hintText: "新密码：8-16个字母与数字结合",
//                 suffixIcon: Container(
//                     // alignment: Alignment.centerRight,
//                     margin: EdgeInsetsDirectional.only(end: 15),
//                     child: Container(
//                       child: Text(
//                         "获取验证码",
//                         style: TextStyle(
//                           fontSize: 14,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                     )))
//           ],
//         ),
//       ),
//     );
