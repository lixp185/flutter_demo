import 'package:shared_preferences/shared_preferences.dart';

// Sp工具类
class SpUtil {

  SpUtil.__internal();


  static SharedPreferences _spf;

  static Future<SharedPreferences> init() async {
    if (_spf == null) {
      _spf = await SharedPreferences.getInstance();
    }
    return _spf;
  }


  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }
  // 判断是否存在数据
  static bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  static Set<String> getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  static get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  static getString(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  static Future<bool> putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf.setString(key, value);
  }

  static bool getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf.getBool(key);
  }

  static Future<bool> putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf.setBool(key, value);
  }

  static int getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf.getInt(key);
  }

  static Future<bool> putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf.setInt(key, value);
  }

  static double getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf.getDouble(key);
  }

  static Future<bool> putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf.setDouble(key, value);
  }

  static List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  static Future<bool> putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf.setStringList(key, value);
  }

  static dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  /// 保存主题颜色，颜色值在 ThemeModel 中
  static Future<bool> saveThemeColorIndex(int value) {
    return _spf.setInt('key_theme_color', value);
  }
  /// 获取主题颜色，颜色值在 ThemeModel 中
  static int getThemeColorIndex() {
    if (hasKey('key_theme_color')) {
      return _spf.getInt('key_theme_color');
    }
    return 0;
  }

  static Future<bool> remove(String key) {
    if (_beforeCheck()) return null;
    return _spf.remove(key);
  }

  static Future<bool> clear() {
    if (_beforeCheck()) return null;
    return _spf.clear();
  }


}
