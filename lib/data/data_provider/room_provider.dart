import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/data/models/room_model.dart';
import 'package:doctor_test/utils/utils.dart';

class RoomProvider {
  //tao phong moi
  static Future<void> createRoom({required Room room}) async {
    try {
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(room.roomId)
          .set(room.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Stream lấy ra tất cả các phòng
  static Stream<List<Room>> getRooms() => FirebaseFirestore.instance
      .collection('rooms')
      .snapshots()
      .transform(Utils.transformer(Room.fromMap));

  // Tìm kiếm phòng theo id
  static Stream<List<Room>> getRoomsById(String roomId) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .where('roomId', isEqualTo: roomId)
        .snapshots()
        .transform(Utils.transformer<Room>((json) => Room.fromMap(json)));
  }

  //delete room
  static Future<void> deleteRoom({Room? room}) async {
    try {
      final data = FirebaseFirestore.instance.collection('rooms');

      data.doc(room!.roomId).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
