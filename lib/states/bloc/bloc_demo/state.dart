
/// 数据层
class DemoState {
  late int num;

  DemoState init() {
    return DemoState()..num = 0;
  }

  DemoState clone() {
    return DemoState()..num = num;
  }
}
