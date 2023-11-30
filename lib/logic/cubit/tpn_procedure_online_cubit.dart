import 'dart:async';

import 'package:doctor_test/data/models/medical/procedure_state.dart';
import 'package:doctor_test/data/models/medical/regimen.dart';
import 'package:doctor_test/data/models/tpn/tpn_procedure.dart';
import 'package:doctor_test/utils/enums/enum.dart';

import 'medical_procedure_cubit.dart';

class TPNProcedureOnlineCubit extends MedicalProcedureCubit {
  late StreamSubscription? regimensSubscription;
  late StreamSubscription? procedureStateSubscription;

  TPNProcedureOnlineCubit({
    required id,
    required name,
    required weight,
    required height,
    required birthday,
    required address,
    required phone,
    required gender,
    procedureType = ProcedureType.unknown,
    currentProcedureId = 'Unknown',
    required procedureId,
    required room,
  }) : super(
          id: id,
          name: name,
          weight: weight,
          height: height,
          birthday: birthday,
          address: address,
          phone: phone,
          gender: gender,
          procedureType: procedureType,
          currentProcedureId: currentProcedureId,
          procedureId: procedureId,
          room: room,
        ) {
    regimensSubscription =
        procedureRef.collection('regimens').snapshots().listen((event) {
      List<Regimen> regimens = [];
      List<dynamic> list = event.docs.map((e) => e.data()).toList();
      for (dynamic x in list) {
        regimens.add(Regimen.fromMap(x));
      }
      emit(TPNProcedure(
        beginTime: state.beginTime,
        state: state.state,
        regimens: regimens,
      ));
    });
    procedureStateSubscription = procedureRef.snapshots().listen((event) {
      //event error
      if (event.data() == null) {
        emit(TPNProcedure(
          beginTime: state.beginTime,
          state: ProcedureState(
              status: ProcedureStatus.firstAsk,
              slowInsulinType: InsulinType.lantus),
          regimens: state.regimens,
        ));
        return;
      }
      ProcedureState tpnState =
          ProcedureState.fromMap(event.data() as Map<String, dynamic>);
      emit(TPNProcedure(
        beginTime: state.beginTime,
        state: tpnState,
        regimens: state.regimens,
      ));
    });
  }
  //emit
  @override
  Future<void> close() {
    regimensSubscription?.cancel();
    procedureStateSubscription?.cancel();
    return super.close();
  }
}

//init
TPNProcedure tpnProcedureOnlineInitial() {
  return TPNProcedure(
    status: 'Đang tải',
    beginTime: DateTime.now(),
    state: ProcedureState(
      status: ProcedureStatus.firstAsk,
    ),
    regimens: [],
  );
}
