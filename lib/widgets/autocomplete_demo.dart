import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/app_bar_search.dart';


class AutocompleteDemo extends StatefulWidget {
  const AutocompleteDemo({Key? key}) : super(key: key);

  @override
  State<AutocompleteDemo> createState() => _AutocompleteDemoState();
}

class _AutocompleteDemoState extends State<AutocompleteDemo> {
  TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Autocomplete<String>(
          optionsBuilder: (a) {
            return searchByArgs(a.text);
          },
          // 构建输入框
          fieldViewBuilder:
              (ctx, textEditingController, focusNode, onFieldSubmitted) {
            _controller = textEditingController;
            return AppBarSearch();
          },
          optionsViewBuilder: (ctx, onSelected, options) {
            return Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Material(
                    color: Colors.grey,
                    child: MediaQuery.removePadding(
                      context: context,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final String text = options.elementAt(index);
                          return InkWell(
                            child: Container(
                              child:
                              Text.rich(formSpan(text, _controller?.text ?? "")),
                            ),
                          );
                        },
                        itemCount: options.length,
                      ),
                      removeTop: true,
                    )));
          },
          onSelected: (s) {},
        ),
      ) ,
      body: Container(
        child: Text("data"),
      ),
    );
  }

  Future<Iterable<String>> searchByArgs(String args) async {
    // 模拟网络请求
    await Future.delayed(const Duration(milliseconds: 200));
    const List<String> data = [
      'toly',
      'toly49',
      'toly42',
      'toly56',
      'card',
      'ls',
      'alex',
      'fan sha',
    ];
    return data.where((String name) => name.contains(args));
  }

  // ---->[高亮某些文字]----
  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    List<String> parts = src.split(pattern);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        span.add(TextSpan(text: parts[i]));
        if (i != parts.length - 1) {
          span.add(TextSpan(text: pattern, style: lightTextStyle));
        }
      }
    } else {
      span.add(TextSpan(text: src));
    }
    return TextSpan(children: span);
  }
}
