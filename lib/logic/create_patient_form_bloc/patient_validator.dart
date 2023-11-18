import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/data/models/room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class PatientValidators {
  static String? required(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return 'Ô này cần được điền';
    }
    return null;
  }

  static String? email(String value) {
    if (FieldBlocValidators.email(value) != null) {
      return 'Đây không phải là định dạng của một email';
    }
    return null;
  }

  static Future<bool> isExistId(String roomId, String id) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .collection('patients')
          .where('id', isEqualTo: id)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class Hospital {
  static String? checkLength10(String value) {
    if (value.length != 10) {
      return 'Mã bệnh nhân phải có 10 kí tự';
    }
    return null;
  }
}
