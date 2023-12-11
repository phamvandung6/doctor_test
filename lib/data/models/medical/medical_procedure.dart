// import 'package:doctor_test/logic/time_controller/sonde_range.dart';
// import 'package:doctor_test/logic/time_controller/tpn_range.dart';
// import 'package:doctor_test/utils/enums/enum.dart';

// import 'procedure_state.dart';
// import 'regimen.dart';

// abstract class MedicalProcedure {
//   String name = 'SondeProcedure';
//   DateTime beginTime;
//   ProcedureState state;
//   List<Regimen> regimens;
//   MedicalProcedure({
//     required this.beginTime,
//     required this.state,
//     required this.regimens,
//     this.name = 'SondeProcedure',
//   });
//   DateTime get lastTime {
//     if (regimens.isEmpty) {
//       return beginTime;
//     }
//     return regimens.last.lastTime;
//   }

//   //toString
//   //get regimen status
//   RegimenStatus get fastStatus {
//     //for down to up
//     for (Regimen x in regimens.reversed) {
//       if (x.regimenActrapidStatus(ActrapidRange()) == RegimenStatus.done) {
//         return RegimenStatus.done;
//       }
//     }
//     if (regimens.isEmpty) {
//       return RegimenStatus.checkingGlucose;
//     }
//     return regimens.last.regimenActrapidStatus(ActrapidRange());
//   }

//   //slowStatus
//   RegimenStatus get slowStatus {
//     //tuy thuoc vao loai insulin tiem cham
//     //for down to up
//     dynamic medicalRange;
//     switch (state.slowInsulinType) {
//       case InsulinType.nph:
//         medicalRange = NPHRange();
//         break;
//       case InsulinType.glargine:
//         medicalRange = GlargineRange();
//         break;
//       case InsulinType.lantus:
//         medicalRange = LantusRange();
//         break;
//       default:
//         return RegimenStatus.done;
//     }
//     if (medicalRange.rangeContain(DateTime.now()) == null) {
//       return RegimenStatus.done;
//     }
//     for (Regimen x in regimens.reversed) {
//       if (x.regimenSlowStatus(medicalRange) == RegimenStatus.done) {
//         return RegimenStatus.done;
//       }
//     }
//     if (regimens.isEmpty) {
//       return RegimenStatus.givingInsulin;
//     }
//     return regimens.last.regimenSlowStatus(medicalRange);
//   }

//   bool get isFull50 {
//     if (regimens.isEmpty) {
//       return false;
//     }
//     return regimens.last.isFull50;
//   }

//   @override
//   String toString() {
//     return '''$name: 
//       {beginTime: $beginTime,\n state: $state,\n regimens: $regimens}
//        ''';
//   }

//   //toMap
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'beginTime': beginTime,
//       'state': state.toMap(),
//       'regimens': [for (Regimen x in regimens) x.toMap()],
//     };
//   }

//   //toDataMap
//   Map<String, dynamic> toDataMap() {
//     final map1 = {
//       'name': name,
//       'beginTime': beginTime,
//     };
//     return {...map1, ...state.toMap()};
//   }
// }
