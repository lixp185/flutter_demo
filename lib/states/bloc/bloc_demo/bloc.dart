import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

/// 逻辑处理层
class DemoBloc extends Bloc<DemoEvent, DemoState> {
  DemoBloc() : super(DemoState().init()) {
    on<InitEvent>(_init);
    on<IncrementEvent>(_add);
  }

  void _init(InitEvent event, Emitter<DemoState> emit) async {
    emit(state.clone());
  }

  _add(IncrementEvent event, Emitter<DemoState> emit) {
    state.num++;
    emit(state.clone());
  }
}
