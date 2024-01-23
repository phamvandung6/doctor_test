import 'dart:async';

import 'package:doctor_test/logic/export_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/enums/enum.dart';
part 'mouth_state.dart';
part 'mouth_event.dart';

class MouthBloc extends Bloc<MouthEvent, MouthState> {
  MouthBloc() : super(const MouthState()) {
    on<CheckGlucose>(_onCheckGlucose);
    on<CheckingTime>(_onCheckingTime);
  }
  void _onCheckGlucose(CheckGlucose event, Emitter<MouthState> emit) {
    if (event.glucoseLevel >= 3.9 && event.glucoseLevel <= 8.3) {
      emit(state.copyWith(
          regimenStatus: RegimenStatus.done, glucoseLevel: event.glucoseLevel));
    } else if (event.glucoseLevel > 8.3 && event.glucoseLevel <= 11.1) {
      emit(state.copyWith(
          regimenStatus: RegimenStatus.waiting,
          glucoseLevel: event.glucoseLevel));
    } else {
      emit(state.copyWith(
          regimenStatus: RegimenStatus.waiting,
          glucoseLevel: event.glucoseLevel));
    }
  }

  Future<RegimenStatus> temp(DateTime time) async {
    var temp = RegimenStatus.waiting;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(DateTime.now());
      if (DateTime.now().hour == time.hour &&
          DateTime.now().minute == time.minute &&
          DateTime.now().second == time.second) {
        temp = RegimenStatus.checkingGlucose;
        timer.cancel();
      }
    });
    return temp;
  }

  Future<void> _onCheckingTime(
      CheckingTime event, Emitter<MouthState> emit) async {
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   print(DateTime.now());
    //   if (DateTime.now().hour == event.time.hour &&
    //       DateTime.now().minute == event.time.minute &&
    //       DateTime.now().second == event.time.second) {
    //     timer.cancel();
    //   }
    // });
    // await temp(event.time);
    // var status = RegimenStatus.waiting;
    // status = await temp(event.time);
    // emit(state.copyWith(regimenStatus: status));
    emit(state.copyWith(regimenStatus: RegimenStatus.checkingGlucose));
  }
}
