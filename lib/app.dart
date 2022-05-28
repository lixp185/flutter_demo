import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/models/app_theme.dart';
import 'package:flutter_demo/utils/bugly.dart';
import 'package:flutter_demo/utils/sp_util.dart';
import 'package:flutter_demo/utils/status.dart';

import 'common/global.dart';
import 'common/theme_common.dart';
import 'widgets/main_page.dart';

class App {
  static init() {
    // FlutterBugly.postCatchedException(() {
    //   //
    // });
    WidgetsFlutterBinding.ensureInitialized();
    Global.instance.init().then((value) => SpUtil.init().then((value) {
          runApp(Status.init(MyApp()));
        }));
    //
    // SpUtil.init().then((value) {
    //   runApp(Status.init(MyApp()));
    // });

    initApp();
    // catchException<String>(() {
    //   return "";
    // });
  }

  static void initApp() {
    // Bugly.init();
  }

  /// 异常捕获处理
  static void catchException<T>(T callback()) {
    /// 捕获异常的回调
    FlutterError.onError = (FlutterErrorDetails details) {
      reportErrorAndLog(details);
    };

    runZonedGuarded<Future<Null>>(
      () async {
        callback();
      },
      // 未捕获的异常的回调
      (Object obj, StackTrace stack) {
        var details = makeDetails(obj, stack);
        reportErrorAndLog(details);
      },
      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          // 收集日志
          collectLog(parent, zone, line);
        },
      ),
    );

    //  重写异常页面
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      print(flutterErrorDetails.toString());
      return Scaffold(
          body: Center(
        child: Text("出了点问题，我们马上修复~"),
      ));
    };
  }

  // 日志拦截, 收集日志
  static void collectLog(ZoneDelegate parent, Zone zone, String line) {
    parent.print(zone, "日志拦截: $line");
  }

  // 上报错误和日志逻辑
  static void reportErrorAndLog(FlutterErrorDetails details) {
    print('上报错误和日志逻辑: $details');
    print(details);
  }

  //  构建错误信息
  static FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
    return FlutterErrorDetails(stack: stack, exception: obj);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme.themeDate,
          darkTheme: ThemeCommon.darkTheme,
          home: MainPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
