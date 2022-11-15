import 'package:flutter/material.dart';

/// 自定义搜索AppBar
class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  AppBarSearch({
    Key? key,
    this.borderRadius = 10,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.height = 34,
    this.value,
    this.leading,
    this.backgroundColor,
    this.suffix,
    this.actions = const [],
    this.hintText,
    this.onTap,
    this.onClear,
    this.onCancel,
    this.onChanged,
    this.onSearch,
    this.onRightTap,
  }) : super(key: key);
  final double? borderRadius;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  // 输入框高度 默认40
  final double height;

  // 默认值
  final String? value;

  // 最前面的组件
  final Widget? leading;

  // 背景色
  final Color? backgroundColor;

  // 搜索框内部后缀组件
  final Widget? suffix;

  // 搜索框右侧组件
  final List<Widget> actions;

  // 输入框提示文字
  final String? hintText;

  // 输入框点击回调
  final VoidCallback? onTap;

  // 清除输入框内容回调
  final VoidCallback? onClear;

  // 清除输入框内容并取消输入
  final VoidCallback? onCancel;

  // 输入框内容改变
  final ValueChanged<String>? onChanged;

  // 点击键盘搜索
  final ValueChanged<String>? onSearch;

  // 点击右边widget
  final VoidCallback? onRightTap;

  @override
  _AppBarSearchState createState() => _AppBarSearchState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppBarSearchState extends State<AppBarSearch> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  bool get isFocus => _focusNode?.hasFocus ?? false; //是否获取焦点

  bool get isTextEmpty => _controller?.text.isEmpty ?? false; //输入框是否为空

  bool get isActionEmpty => widget.actions.isEmpty; // 右边布局是否为空

  bool isShowCancel = false;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.value != null) _controller?.text = widget.value ?? "";
    // 焦点获取失去监听
    _focusNode?.addListener(() => setState(() {}));
    // 文本输入监听
    _controller?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // 清除输入框内容
  void _onClearInput() {
    // setState(() {
    _controller?.clear();
    _controller?.text = "";
    // });
    widget.onClear?.call();
  }

  // 取消输入框编辑失去焦点
  void _onCancelInput() {
    setState(() {
      _controller?.clear();
      _focusNode?.unfocus(); //失去焦点
    });
    // 执行onCancel
    widget.onCancel?.call();
  }

  Widget _suffix() {
    if (!isTextEmpty) {
      return InkWell(
        onTap: _onClearInput,
        child: SizedBox(
          width: widget.height,
          height: widget.height,
          child: Icon(Icons.cancel, size: 22, color: Color(0xFF999999)),
        ),
      );
    }
    return widget.suffix ?? SizedBox();
  }

  List<Widget> _actions() {
    List<Widget> list = [];
    if (isActionEmpty) {
      list.add(InkWell(
        onTap: widget.onRightTap ?? _onCancelInput,
        child: Container(
          constraints: BoxConstraints(minWidth: 48),
          alignment: Alignment.center,
          child: Text(
            '搜索',
          ),
        ),
      ));
    } else if (!isActionEmpty) {
      list.addAll(widget.actions);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      //阴影z轴
      elevation: 0,
      // 标题与其他控件的间隔
      titleSpacing: 0,
      leadingWidth: 40,
      leading: widget.leading ??
          InkWell(
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 16,
            ),
            onTap: () {},
          ),
      title:  Hero(
          tag: 'search',
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              height: widget.height,
              child: TextField(
                // 是否自动获取焦点
                autofocus: widget.autoFocus ?? false,
                // 焦点控制
                focusNode: _focusNode,
                // 与输入框交互控制器
                controller: _controller,

                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                // 键盘动作右下角图标
                textInputAction: TextInputAction.search,
                onTap: widget.onTap,
                // 输入框内容改变回调
                onChanged: widget.onChanged,
                onSubmitted: widget.onSearch,
                //输入框完成触发
                //装饰
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: EdgeInsetsDirectional.only(start: 5, end: 5),
                    child: Icon(
                      Icons.search_rounded,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ),

                  //添加内部图标之后，图标和文字会有间距，实现这个方法，不用写任何参数即可解决
                  prefixIconConstraints: const BoxConstraints(),
                  suffixIconConstraints: const BoxConstraints(),
                  suffixIcon: InkWell(
                      onTap: _onClearInput,
                      child: Visibility(
                        child: Container(
                          margin: EdgeInsetsDirectional.only(end: 5),
                          child: const Icon(
                            Icons.cancel,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                        visible: !isTextEmpty,
                      )),

                  // isDense: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsetsDirectional.only(
                      end: 15, ),

                  hintText: widget.hintText ?? '请输入关键字',
                  hintStyle:
                  TextStyle(fontSize: 14, color: Colors.grey),

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 20),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 20),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 20),
                    ),
                  ),
                ),
              ),
            ),
          )),
      actions: _actions(),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }
}
