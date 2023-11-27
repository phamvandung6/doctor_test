import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String roomId;
  final String roomName;
  //id trên firebase chứ không phải là id của phòng
  // final String id;

  bool? isDeleted;

  Room({
    required this.roomId,
    required this.roomName,
    // required this.id,
    this.isDeleted,
  }) {
    isDeleted = isDeleted ?? false;
  }

  @override
  List<Object?> get props => [roomId, roomName, isDeleted];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'roomName': roomName,
      // 'id': id,
      'isDeleted': isDeleted,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      roomId: map['roomId'] as String,
      roomName: map['roomName'] as String,
      // id: map['id'] as String,
      isDeleted: map['isDeleted'] as bool?,
    );
  }

  Room copyWith({
    String? roomId,
    String? roomName,
    String? id,
    bool? isDeleted,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      // id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
