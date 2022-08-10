import 'package:flutter/cupertino.dart';

void main() {
//   String a = '"Dart基础知识"';
//   String b = "'Dart基础知识'";
//   String c = '''Dart
// 基础知识''';
//   String d = String.fromCharCodes(Runes("\u2665"));
//
//   num a = 1;
//   int b = 1;
//   double c = 0.5;
//   // print(a);
//   // a = b+c;
//   print(a);
//
//   /// 编译期报错
//   // b= b+a;
//   print(b);
//   print(c);
//   print(d);
//
//   String x = a == 0 ? "x" : "b";
//   String y = a == 0
//       ? "x"
//       : b == 0
//           ? "y"
//           : "z";
//   print(x);
//   print(y);
//
//   Set s = <int>{1, 2, 3};
//   print(s);
//
//   Map<String, Object> map = {"a": "0", "b": 1};
//
//   print(map);

  dynamic z;
  z = "dart";
  print(z);
  z = 123;
  print(z);
  z = true;
  print(z);

  // int a =0;
  late int a;

  Object? x;
  z.abc();
  print(x?.toString());
}

abstract class A {
  m();
}

class B {
  Function()? back;
  Future<String?> Function(int page, Function()? back)? loadData;

  Future<String?> test() async {
    return await loadData?.call(1, () {});
  }
//

}

/// 生命
mixin Life {
  eat() {
    /// 吃
  }

  /// 性别男特点
  man() {}

  /// 性别女特点
  woman() {}
}

/// 动物
mixin Zoo {
  /// 速度快特点
  quickly() {}

  ///...
}

class Man with Life {
  @override
  man() {
    return super.man();
  }
}

class Cat with Life, Zoo {
  @override
  eat() {
    return super.eat();
  }

  @override
  quickly() {
    return super.quickly();
  }
}

// class DartDemo extends A implements B {
//   num a = 1;
//
//   double b = 0;
//
//   static const int x = 0;
//
//   test() {
//     if (a == b) {}
//   }
//
//   @override
//   m() {}
//
//   @override
//   n() {
//     throw UnimplementedError();
//   }
// }
