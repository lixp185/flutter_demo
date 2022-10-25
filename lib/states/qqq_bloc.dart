import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qqq_event.dart';
part 'qqq_state.dart';

class QqqBloc extends Bloc<QqqEvent, QqqState> {
  QqqBloc() : super(QqqInitial()) {
    on<QqqEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
