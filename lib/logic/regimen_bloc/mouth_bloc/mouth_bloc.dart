import 'dart:async';

import 'package:doctor_test/logic/export_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/enums/enum.dart';
part 'mouth_state.dart';
part 'mouth_event.dart';

class MouthBloc extends Bloc<MouthEvent, MouthState> {
  MouthBloc() : super(const MouthState()) {
    on<CheckGlucose>(_onCheckGlucose);
    on<CheckingTime>(_onCheckingTime);
    on<CheckingDone>(_onCheckingDone);
    on<AddingDone>(_onAddDoneList);
  }
  void _onCheckGlucose(CheckGlucose event, Emitter<MouthState> emit) {
    if (event.glucoseLevel < 3.9) {
      emit(state.copyWith(regimenStatus: RegimenStatus.error));
      return;
    }
    emit(state.copyWith(
        glucoseLevel: event.glucoseLevel,
        regimenStatus: RegimenStatus.waiting));
    if (event.glucoseLevel >= 3.9 && event.glucoseLevel <= 8.3) {
      var doneList1 = <bool>[];
      for (var i = 0; i < state.doneList.length; i++) {
        doneList1.add(state.doneList[i]);
      }
      doneList1.add(true);
      emit(state.copyWith(doneList: doneList1));
    }
  }

  void _onAddDoneList(AddingDone event, Emitter<MouthState> emit) {
    List<bool> doneList1 = [];
    for (var i = 0; i < state.doneList.length; i++) {
      doneList1.add(state.doneList[i]);
    }
    doneList1.add(event.done);
    emit(state.copyWith(doneList: doneList1));
    print(state.regimenStatus);
  }

  bool checkDoneList(List<bool> doneList) {
    int count = 0;
    for (var i = 0; i < doneList.length; i++) {
      if (doneList[i] == true) {
        count++;
      }
    }
    return count == 2 ? true : false;
  }

  bool checkFailList(List<bool> doneList) {
    if (doneList.contains(true)) {
      return true;
    }
    return false;
  }

  Future<void> _onCheckingTime(
      CheckingTime event, Emitter<MouthState> emit) async {
    emit(state.copyWith(regimenStatus: RegimenStatus.checkingGlucose));
  }

  Future<void> _onCheckingDone(
      CheckingDone event, Emitter<MouthState> emit) async {
    if (checkDoneList(state.doneList)) {
      emit(state.copyWith(regimenStatus: RegimenStatus.done));
    }
  }
}
