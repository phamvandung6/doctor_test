import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RoomValidators {
  //Ô phải bắt buộc điền
  static String? required(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return 'Ô này cần được điền';
    }
    return null;
  }

  //Validate email
  static String? email(String value) {
    if (FieldBlocValidators.email(value) != null) {
      return 'Đây không phải là định dạng của một email';
    }
    return null;
  }

  //Kiểm tra id có tồn tại trên firebase không?
  static Future<bool> isExistId(String id) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .where('roomId', isEqualTo: id)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
