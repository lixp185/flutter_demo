import 'dart:async';

import 'package:flutter_demo/pages/function/event/event_bus.dart';



class Event {
  static final EventBus eventBus = EventBus(sync: false);
//  static final EventBus eventBus2 =
//     EventBus.customController(StreamController());
}

class CountEvent {
  int data = 0;

  CountEvent(this.data);
}
