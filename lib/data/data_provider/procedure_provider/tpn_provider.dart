import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/model_export.dart';

class TPNProvider {
  //tạo thủ tục mới (procedureType, currentProcedureId)
  static Future<void> createTPNProcedure({
    required Patient patient,
    required TPNModel tpnProcedure,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('patient_treatmen')
          .doc(patient.id)
          .collection('procedures')
          .doc(tpnProcedure.beginTime.toString())
          .set(tpnProcedure.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
