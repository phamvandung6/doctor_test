import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/utils/utils.dart';

class PatientProvider {
  //Thêm bệnh nhân
  static Future<void> createPatient({String? roomId, Patient? patient}) async {
    try {
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .collection('patients')
          .doc(patient!.id)
          .set(patient.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Stream lấy ra tất cả các bệnh nhân
  static Stream<List<Patient>> getPatients({Room? room}) =>
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(room!.roomId)
          .collection('patients')
          .snapshots()
          .transform(Utils.transformer(Patient.fromMap));

  // Xóa bệnh nhân
  static Future<void> deletePatient({Room? room, Patient? patient}) async {
    try {
      final data = FirebaseFirestore.instance
          .collection('rooms')
          .doc(room!.roomId)
          .collection('patients')
          .doc(patient!.id);
      data.delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Tìm kiếm bệnh nhân theo id
  static Stream<List<Patient>> getPatientsById(
      {String? roomId, String? patientId}) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('patients')
        .where('id', isEqualTo: patientId)
        .snapshots()
        .transform(Utils.transformer<Patient>((json) => Patient.fromMap(json)));
  }
}
