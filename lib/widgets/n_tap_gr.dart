import 'dart:async';

import 'package:flutter/gestures.dart';

typedef NTapUpCallBack = Function();
typedef NTapDownCallBack = Function(TapDownDetails details, int n);

/// 多点击手势识别器
class NTapGestureRecognizer extends GestureRecognizer {
  /// 最大连击次数
  int maxN = 2;

  /// 最大连击回调 抬起
  NTapUpCallBack? onNTap;

  /// 最大连击回调 按下
  NTapDownCallBack? onNTapDown;

  /// 上次触点信息
  _TapTracker? _prevTap;

  /// 连击次数
  int tapCount = 0;

  final Map<int, _TapTracker> _trackers = <int, _TapTracker>{};

  /// 定时器
  Timer? _tapTimer;

  NTapGestureRecognizer({this.maxN = 2});

  @override
  void acceptGesture(int pointer) {}

  @override
  void rejectGesture(int pointer) {
    // 宣告失败
    var tracker = _trackers[pointer];
    if (tracker == null && _prevTap != null && _prevTap!.pointer == pointer) {
      tracker = _prevTap;
    }
    if (tracker != null) {
      _reject(tracker);
    }
  }

  // 手势主动宣告失败 通知竞技场管理者
  _reject(_TapTracker tracker) {
    _trackers.remove(tracker.pointer);
    tracker.entry.resolve(GestureDisposition.rejected);
    // 将触点信息对应的_handlerEvent从路由中删除
    _freezeTracker(tracker);
    if (_prevTap != null) {
      if (tracker == _prevTap) {
        _reset();
      } else {
        _checkCancel();
        if (_trackers.isEmpty) _reset();
      }
    }
  }

  void _freezeTracker(_TapTracker tracker) {
    tracker.stopTrackingPointer(_handlerEvent);
  }

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (_prevTap == null) {
      switch (event.buttons) {
        case kPrimaryButton:
          if (onNTap == null && onNTapDown == null) {
            return false;
          }
          break;
        default:
          return false;
      }
    }
    return super.isPointerAllowed(event);
  }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    tapCount++;
    if (_prevTap != null) {
      if (_prevTap!.isWithinGlobalTolerance(event, kDoubleTapSlop)) {
        //校验上次触点信息和本次触点信息偏移如果大于100个像素。直接return。
        return;
      } else if (!_prevTap!.hasElapsedMinTime() ||
          !_prevTap!.hasSameButton(event)) {
        // 校验两次点击之间
        _reset();
        return _trackTap(event);
      } else if (onNTapDown != null) {
        final TapDownDetails tapDownDetails = TapDownDetails(
          kind: event.kind,
          localPosition: event.localPosition,
          globalPosition: event.position,
        );
        // 回调onTapDown
        invokeCallback('onTapDown', () {
          onNTapDown!(tapDownDetails, tapCount);
        });
      }
    }
    // 按下 创建触点信息 注册路由等操作
    _trackTap(event);
  }

  _handlerEvent(PointerEvent pointerEvent) {
    _TapTracker? tracker = _trackers[pointerEvent.pointer];
    if (pointerEvent is PointerUpEvent) {
      // 抬起操作
      if (_prevTap == null || tapCount != maxN) {
        // 注册
        if (tracker != null) registerPrevTap(tracker);
      } else {
        if (tracker != null) registerLastTap(tracker);
      }
    } else if (pointerEvent is PointerMoveEvent) {
      if (tracker!.isWithinGlobalTolerance(pointerEvent, kDoubleTapTouchSlop)) {
        _reject(tracker);
      }
    } else if (pointerEvent is PointerCancelEvent) {
      _reject(tracker!);
    }
  }

  @override
  String get debugDescription => ' n click tap';

  void _trackTap(PointerDownEvent event) {
    stopNTapTimer();
    final _TapTracker _tapTracker = _TapTracker(
        event: event,
        entry: GestureBinding.instance.gestureArena.add(event.pointer, this),
        doubleTapMinTime: kDoubleTapMinTime,
        gestureSettings: gestureSettings);
    _trackers[event.pointer] = _tapTracker;
    // 将手势触点信息和handler注册到触点路由
    _tapTracker.startTrackingPointer(_handlerEvent, event.transform);
  }

  void _reset() {
    stopNTapTimer();
    if (_prevTap != null) {
      if (_trackers.isNotEmpty) _checkCancel();
      final _TapTracker tracker = _prevTap!;
      _prevTap = null;
      if (tapCount == 1) {
        tracker.entry.resolve(GestureDisposition.rejected);
      } else {
        tracker.entry.resolve(GestureDisposition.accepted);
      }
      _freezeTracker(tracker);
      GestureBinding.instance.gestureArena.release(tracker.pointer);
    }
    _clearTrackers();
    tapCount = 0;
  }

  void startNTapTimer() {
    _tapTimer ??= Timer(kDoubleTapTimeout, _reset);
  }

  void stopNTapTimer() {
    // 取消定时器
    _tapTimer?.cancel();
    _tapTimer = null;
  }

  void _checkCancel() {}

  void _clearTrackers() {
    _trackers.values.toList().forEach((element) {
      _reject(element);
    });
  }

  //  点击抬起手指
  void registerPrevTap(_TapTracker tracker) {
    startNTapTimer();
    // 竞技场挂起
    GestureBinding.instance.gestureArena.hold(tracker.pointer);
    //  取消触点追踪
    _freezeTracker(tracker);
    // 删除抬起的触点映射
    _trackers.remove(tracker.pointer);
    // 更新上一次点击对象
    _prevTap = tracker;
  }

  void registerLastTap(_TapTracker tracker) {
    tracker.entry.resolve(GestureDisposition.accepted);
    _freezeTracker(tracker);
    _checkUp(tracker.initialButtons);
    _reset();
  }

  void _checkUp(int initialButtons) {
    if (onNTap != null) {
      invokeCallback('onNTap', onNTap!);
    }
  }
}

/// TapTracker helps track individual tap sequences as part of a
/// larger gesture.
class _TapTracker {
  _TapTracker({
    required PointerDownEvent event,
    required this.entry,
    required Duration doubleTapMinTime,
    required this.gestureSettings,
  })  : pointer = event.pointer,
        _initialGlobalPosition = event.position,
        initialButtons = event.buttons,
        _doubleTapMinTimeCountdown =
            _CountdownZoned(duration: doubleTapMinTime);

  final DeviceGestureSettings? gestureSettings;
  final int pointer;
  final GestureArenaEntry entry;
  final Offset _initialGlobalPosition;
  final int initialButtons;
  final _CountdownZoned _doubleTapMinTimeCountdown;

  bool _isTrackingPointer = false;

  void startTrackingPointer(PointerRoute route, Matrix4? transform) {
    if (!_isTrackingPointer) {
      _isTrackingPointer = true;
      GestureBinding.instance.pointerRouter.addRoute(pointer, route, transform);
    }
  }

  void stopTrackingPointer(PointerRoute route) {
    if (_isTrackingPointer) {
      _isTrackingPointer = false;
      GestureBinding.instance.pointerRouter.removeRoute(pointer, route);
    }
  }

  bool isWithinGlobalTolerance(PointerEvent event, double tolerance) {
    final Offset offset = event.position - _initialGlobalPosition;
    return offset.distance >= tolerance;
  }

  bool hasElapsedMinTime() {
    return _doubleTapMinTimeCountdown.timeout;
  }

  bool hasSameButton(PointerDownEvent event) {
    return event.buttons == initialButtons;
  }
}

class _CountdownZoned {
  _CountdownZoned({required Duration duration}) {
    Timer(duration, _onTimeout);
  }

  bool _timeout = false;

  bool get timeout => _timeout;

  void _onTimeout() {
    _timeout = true;
  }
}
