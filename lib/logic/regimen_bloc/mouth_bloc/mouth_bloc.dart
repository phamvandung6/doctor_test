import 'dart:async';

import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/models/room_model.dart';
import 'package:doctor_test/repositories/firebase_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/patient_model.dart';
import '../../../utils/enums/enum.dart';
part 'mouth_state.dart';
part 'mouth_event.dart';

class MouthBloc extends Bloc<MouthEvent, MouthState> {
  MouthBloc() : super(const MouthState()) {
    on<CheckGlucose>(_onCheckGlucose);
    on<CheckingTime>(_onCheckingTime);
    on<CheckingDone>(_onCheckingDone);
    on<GuideMixing>(_onGuideMixing);
    on<AddRoomPatient>(_onAddRoomPatient);
  }
  void _onCheckGlucose(CheckGlucose event, Emitter<MouthState> emit) async {
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
    } else {
      var doneList1 = <bool>[];
      for (var i = 0; i < state.doneList.length; i++) {
        doneList1.add(state.doneList[i]);
      }
      doneList1.add(false);
      emit(state.copyWith(doneList: doneList1));
    }
    await FirestoreRepository.addRegimen(
        room: state.room, patient: state.patient);
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

  Future<void> _onAddRoomPatient(
      AddRoomPatient event, Emitter<MouthState> emit) async {
    emit(state.copyWith(room: event.room, patient: event.patient));
  }

  Future<void> _onCheckingTime(
      CheckingTime event, Emitter<MouthState> emit) async {
    DateTime temp = event.time.add(const Duration(minutes: 1));
    int range = temp.difference(DateTime.now()).inSeconds;
    for (var i = 0; i < range; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (DateTime.now().difference(event.time).inSeconds == 0) {
        print('done');
      }
    }
    emit(state.copyWith(regimenStatus: RegimenStatus.checkingGlucose));
  }

  Future<void> _onCheckingDone(
      CheckingDone event, Emitter<MouthState> emit) async {
    if (checkDoneList(state.doneList)) {
      emit(state.copyWith(regimenStatus: RegimenStatus.done));
    }
  }

  Future<void> _onGuideMixing(
      GuideMixing event, Emitter<MouthState> emit) async {
    emit(state.copyWith(regimenStatus: RegimenStatus.guideMixing));
  }
}
