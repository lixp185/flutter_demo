// 定义一个OnName函数 相当于原生接口中的函数
typedef OnName = void Function(String, String);

///定义一个回调类
class CallBack {
  OnName? name;

  CallBack({this.name});
}

// 再定义一个类

class Name {

  loadName(OnName? onName) {


    onName?.call("老李", "李云龙");
  }
}
