

/// 写数据
class CubitState {
  late int num;


  CubitState init() {
    return CubitState()..num = 2;
  }

  CubitState clone() {
    return CubitState()..num = num;
  }
}
