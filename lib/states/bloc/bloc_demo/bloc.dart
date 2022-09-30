import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

/// 逻辑处理层
class DemoBloc extends Bloc<DemoEvent, DemoState> {
  ///构造方法
  DemoBloc() : super(DemoState().init()) {
    /// on 注册所有事件
    on<InitEvent>(_init);
    on<IncrementEvent>(_add);
  }

  /// 私有化逻辑方法 暴露Event事件
  void _init(InitEvent event, Emitter<DemoState> emit) {
    emit(state.clone());
  }

  _add(IncrementEvent event, Emitter<DemoState> emit) {
    state.num++;
    emit(state.clone());
  }
}
