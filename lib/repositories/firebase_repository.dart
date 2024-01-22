import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/models/patient_model.dart';
import 'package:doctor_test/models/room_model.dart';

class FirestoreRepository {
  // create room
  static Future<void> createRoom({Room? room}) async {
    try {
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(room!.roomId)
          .set(room.toMap());
      // .add(room!.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Room> getRoom({String? id}) async {
    try {
      final data =
          await FirebaseFirestore.instance.collection('rooms').doc(id).get();
      return Room.fromMap(data.data()!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //get rooms
  static Future<List<Room>> getRooms() async {
    List<Room> roomList = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection('rooms')
          .snapshots()
          .first;

      for (var element in data.docs) {
        roomList.add(Room.fromMap(element.data()));
      }
      return roomList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //update room
  static Future<void> updateRoom({Room? room}) async {
    try {} catch (e) {
      throw Exception(e.toString());
    }
  }

  //delete room
  static Future<void> deleteRoom({Room? room}) async {
    try {} catch (e) {
      throw Exception(e.toString());
    }
  }

  //create patient
  static Future<void> createPatient({Patient? patient}) async {
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(patient!.id)
          .set(patient.toMap());
      // .add(room!.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //get all patients
  static Future<List<Patient>> getPatients(Room? room) async {
    List<Patient> patientsList = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(room!.roomId)
          .collection('patients')
          .snapshots()
          .first;

      for (var patient in data.docs) {
        patientsList.add(Patient.fromMap(patient.data()));
      }
      return patientsList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //update patients
  static Future<void> updatePatient(
      {required Room room, required Patient patient}) async {
    try {
      final data = FirebaseFirestore.instance
          .collection('rooms')
          .doc(room.roomId)
          .collection('patients')
          .doc(patient.id);
      data.update(patient.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //delete patient
  static Future<void> deletePatient({Patient? patient}) async {
    try {
      final data = FirebaseFirestore.instance.collection('patients');

      data.doc(patient!.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
