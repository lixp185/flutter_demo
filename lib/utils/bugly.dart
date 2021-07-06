import 'package:flutter_bugly/flutter_bugly.dart';

class Bugly {
  static const String BUGLY_APP_ID_ANDROID = "68c358fc79";
  static const String BUGLY_APP_ID_IOS = ""; // iOS暂未申请id

  Bugly._internal(); //单例

  ///初始化BugLy
  static void init() {
    FlutterBugly.init(
            androidAppId: BUGLY_APP_ID_ANDROID, iOSAppId: BUGLY_APP_ID_IOS)
        .then((_result) {
      print("Bugly初始化结果: ${_result.isSuccess}");
    });
  }
}
