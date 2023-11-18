import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String roomId;
  final String roomName;
  const Room({
    required this.roomId,
    required this.roomName,
  });

  Room copyWith({
    String? roomId,
    String? roomName,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'roomName': roomName,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      roomId: map['roomId'] as String,
      roomName: map['roomName'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [roomId, roomName];
}
