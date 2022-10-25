

/// 写数据
class CubitState {
  late int num;


  CubitState init() {
    return CubitState()..num = 0;
  }

  CubitState clone() {
    return CubitState()..num = num;
  }
}
