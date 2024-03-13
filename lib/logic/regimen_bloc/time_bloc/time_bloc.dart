import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeState(time: DateTime.now())) {
    on<TimeStarted>(_onTimeStarted);
    on<TimeTicked>(_onTimeTicked);
    on<TimeDone>(_onTimeDone);
  }
  void _onTimeStarted(TimeStarted event, Emitter<TimeState> emit) {
    emit(state.copyWith(time: DateTime.now(), isDone1: true));
  }

  void _onTimeTicked(TimeTicked event, Emitter<TimeState> emit) async {
    DateTime temp = state.time.add(const Duration(minutes: 2));
    int range = temp.difference(DateTime.now()).inSeconds;
    while (range > 0) {
      await Future.delayed(const Duration(seconds: 1));
      range = temp.difference(DateTime.now()).inSeconds;
      print(range);
      // emit(state.copyWith(time: temp));
      if (state.isDone1) {
        print(state.isDone1);
        break;
      }
    }
    emit(state.copyWith(isDone1: false));
    if (range == 0) {
      emit(state.copyWith(isDone: false));
    }
    // await Future.delayed(const Duration(seconds: 5));
  }

  void _onTimeDone(TimeDone event, Emitter<TimeState> emit) {
    emit(state.copyWith(isDone1: event.isDone1));
  }
}
