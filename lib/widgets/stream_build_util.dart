import 'stream_build.dart';

/// 局部刷新工具类
class StreamBuildUtil {
  static StreamBuildUtil? _instance;

  StreamBuildUtil._();

  factory StreamBuildUtil() {
    return instance;
  }

  static StreamBuildUtil get instance => _getInstance();

  static StreamBuildUtil _getInstance() {
    if (_instance == null) {
      _instance = StreamBuildUtil._();
    }
    return _instance ?? StreamBuildUtil._();
  }

  final Map<String, StreamBuild> dataBus = {};

  /// key = 刷新局部标记
  StreamBuild getStream(String key) {
    if (!dataBus.containsKey(key)) {
      StreamBuild streamBuild = StreamBuild.instance(key);
      dataBus[key] = streamBuild;
    }
    if (dataBus[key] == null) {
      return StreamBuild.instance(key);
    } else {
      return dataBus[key]!;
    }
  }

  void onDisposeAll() {
    if (dataBus.length > 0) {
      dataBus.values.forEach((f) => f.dis());
      dataBus.clear();
    }
  }

  void onDisposeKey(String? key) {
    if (dataBus.length > 0) {
      dataBus.remove(key);
    }
  }
}
