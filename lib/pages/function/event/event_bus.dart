import 'dart:async';

/// 基于Stream订阅分发跨组件的通信方式
class EventBus {
  StreamController _streamController;

  /// 事件总线
  StreamController get streamController => _streamController;

  /// Creates an [EventBus].
  ///
  /// If [sync] is true, events are passed directly to the stream's listeners
  /// during a [fire] call. If false (the default), the event will be passed
  /// to the listeners at a later time, after the code creating the event has completed.
  /// sync true add时直接发送 不保证一定收到数据
  /// sync false 不保证何时收到数据 在add完成之后通知监听器
  EventBus({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  /// 自定义控制器 单线通知 StreamController()
  EventBus.customController(StreamController controller)
      : _streamController = controller;

  /// 监听接收数据 支持多个监听者
  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// 发送数据
  void fire(event) {
    streamController.add(event);
  }

  /// 关闭总事件 一般情况下全局EventBus不需要调用这个方法
  /// 非全局EventBus在退出时调用
  void destroy() {
    _streamController.close();
  }
}
