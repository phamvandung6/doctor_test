// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor_test/data/models/model_export.dart';
// import 'package:doctor_test/utils/enums/enum.dart';

// import '../../../logic/export_bloc.dart';

// class TPNCubit extends Cubit<TPNModel> {
//   final Patient patient;
//   final TPNModel tpnModel;

//   TPNCubit(
//     super.initialState,
//     this.patient,
//     this.tpnModel,
//   );

//   DocumentReference get procedureRef {
//     return FirebaseFirestore.instance
//         .collection('patient_treatmen')
//         .doc(patient.id)
//         .collection('procedures')
//         .doc(tpnModel.beginTime.toString());
//   }

//   //thêm medical action
//   Future<void> addMedicalAction(dynamic medicalAction) async {
//     DocumentReference lastRegimen = await lastRegimenRef();
//     await lastRegimen.update({
//       'medicalAction': FieldValue.arrayUnion([medicalAction.toMap()])
//     });
//   }

//   Future<DocumentReference> lastRegimenRef() async {
//     CollectionReference regimensRef = FirebaseFirestore.instance
//         .collection('patient_treatmen')
//         .doc(patient.id)
//         .collection('regimens');
//     List<QueryDocumentSnapshot> docs = (await regimensRef.get()).docs;

//     return regimensRef.doc(docs.last.id);
//   }

//   //chuyen den SondeStatus tiep theo
//   Future<void> goToNextStatus() async {
//     TPNModel tpnModel = state;
//     ProcedureStatus nextStatus = ProcedureStatus.firstAsk;
//     switch (tpnModel.status) {
//       case ProcedureStatus.firstAsk:
//         nextStatus = ProcedureStatus.noInsulin;
//         break;
//       case ProcedureStatus.noInsulin:
//         nextStatus = ProcedureStatus.finish;
//         break;
//       case ProcedureStatus.yesInsulin:
//         nextStatus = ProcedureStatus.finish;
//         break;
//       default:
//     }
//     await updateProcedureStatus(
//         patient: patient, tpnmodel: tpnModel, procedureStatus: nextStatus);
//   }

//   Future<void> updateProcedureStatus({
//     required ProcedureStatus procedureStatus,
//     required Patient patient,
//     required TPNModel tpnmodel,
//   }) async {
//     FirebaseFirestore.instance
//         .collection('patient_treatmen')
//         .doc(patient.id)
//         .collection('procedures')
//         .doc(tpnmodel.beginTime.toString())
//         .update({'status': procedureStatus});
//   }
// }
