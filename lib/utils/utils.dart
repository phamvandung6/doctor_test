import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }

  //Stream ban đầu chứa QuerySnapshot sẽ được biến đổi
  //thành Stream chứa danh sách các đối tượng T sau khi áp dụng transformer.
  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<T>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> data,
                EventSink<List<T>> sink) {
              final snaps = data.docs.map((doc) => doc.data()).toList();
              final objects = snaps.map((json) => fromJson(json)).toList();

              sink.add(objects);
            },
          );
}
