// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor_test/data/models/patient_model.dart';
// import 'package:doctor_test/data/models/room_model.dart';
// import 'package:get_storage/get_storage.dart';

// class FirestoreRepository {
//   // create room
//   static Future<void> createRoom({Room? room}) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('rooms')
//           .doc(room!.id)
//           .set(room.toMap());
//       // .add(room!.toMap());
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //get rooms
//   static Future<List<Room>> getRooms() async {
//     List<Room> roomList = [];
//     try {
//       final data = await FirebaseFirestore.instance.collection('rooms').get();

//       for (var room in data.docs) {
//         roomList.add(Room.fromMap(room.data()));
//       }
//       return roomList;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //update room
//   static Future<void> updateRoom({Room? room}) async {
//     try {
//       final data =
//           FirebaseFirestore.instance.collection(GetStorage().read('rooms'));

//       data.doc(room!.id).update(room.toMap());
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //delete room
//   static Future<void> deleteRoom({Room? room}) async {
//     try {
//       final data = FirebaseFirestore.instance.collection('rooms');

//       data.doc(room!.id).delete();
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //create patient
//   static Future<void> createPatient({Patient? patient}) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('patients')
//           .doc(patient!.id)
//           .set(patient.toMap());
//       // .add(room!.toMap());
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //get all patients
//   static Future<List<Patient>> getPatients() async {
//     List<Patient> patientsList = [];
//     try {
//       final data = await FirebaseFirestore.instance
//           .collection('patients')
//           // .orderBy('timestamp')
//           .get();

//       for (var patient in data.docs) {
//         patientsList.add(Patient.fromMap(patient.data()));
//       }
//       return patientsList;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //update patients
//   static Future<void> updatePatient({Patient? patient}) async {
//     try {
//       final data =
//           FirebaseFirestore.instance.collection(GetStorage().read('patients'));

//       data.doc(patient!.id).update(patient.toMap());
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //delete patient
//   static Future<void> deletePatient({Patient? patient}) async {
//     try {
//       final data = FirebaseFirestore.instance.collection('patients');

//       data.doc(patient!.id).delete();
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
