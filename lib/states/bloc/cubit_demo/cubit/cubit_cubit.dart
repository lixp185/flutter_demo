import 'package:bloc/bloc.dart';

import 'cubit_state.dart';

/// 写逻辑
class CubitCubit extends Cubit<CubitState> {
  CubitCubit() : super(CubitState().init());

  ///自增
  void increment() => emit(state.clone()..num = state.num + 1);
}
