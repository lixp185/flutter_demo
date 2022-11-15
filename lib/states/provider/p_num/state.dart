/// 数据层
class PNumState {
  int num;

  // 初始化
  PNumState({this.num = 0});

  PNumState clone() {
    // 获取最新对象
    return PNumState()..num = num;
  }
}
