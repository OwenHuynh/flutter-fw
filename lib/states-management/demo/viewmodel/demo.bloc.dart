import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/states-management/demo/viewmodel/demo.event.dart';
import 'package:flutter_fm/states-management/demo/viewmodel/demo.state.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  DemoBloc() : super(DemoState.initial()) {
    on<OnIncrement>(_onIncrement);
    on<OnDecrement>(_onDecrement);
  }

  FutureOr<void> _onIncrement(OnIncrement event, Emitter<DemoState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  FutureOr<void> _onDecrement(OnDecrement event, Emitter<DemoState> emit) {
    emit(state.copyWith(count: state.count - 1));
  }
}
