import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class XListener extends Listener {
  final PointerDownEventListener? onPointerDown;
  final PointerUpEventListener? onPointerUp;

  const XListener({
    super.key,
    this.onPointerDown,
    this.onPointerUp,
    behavior = HitTestBehavior.deferToChild,
    super.child,
  }) : assert(behavior != null);


  @override
  RenderPointerListener createRenderObject(BuildContext context) {
    return XRenderPointerListener(
      onPointerDown,
      onPointerUp
    );
  }
}

class XRenderPointerListener extends RenderPointerListener {
  final PointerDownEventListener? onPointerDown;
  final PointerUpEventListener? onPointerUp;

  XRenderPointerListener(this.onPointerDown, this.onPointerUp);

  @override
  void performLayout() {
    print('cccc $constraints');

    super.performLayout();

  }
  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry<HitTestTarget> entry) {
    if (event is PointerDownEvent) {
      return onPointerDown?.call(event);
    }
    if (event is PointerUpEvent) {
      return onPointerUp?.call(event);
    }

  }



  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    print('xxxxx hitTest ${position.toString()}');
    result.add(BoxHitTestEntry(this, position));
    return true;
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }
}


