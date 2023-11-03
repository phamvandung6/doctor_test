part of 'room_bloc.dart';

class RoomState extends Equatable {
  //Danh sách tất cả các phòng
  final List<Room> allRooms;
  //Danh sách phòng đã xóa 
  final List<Room> removedRooms;
  const RoomState({
    this.allRooms = const <Room>[],
    this.removedRooms = const <Room>[],
  });

  @override
  List<Object> get props => [allRooms, removedRooms];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allRooms': allRooms.map((x) => x.toMap()).toList(),
      'removedRooms': removedRooms.map((x) => x.toMap()).toList(),
    };
  }

  factory RoomState.fromMap(Map<String, dynamic> map) {
    return RoomState(
      allRooms: List<Room>.from(
        (map['allRooms'] as List<int>).map<Room>(
          (x) => Room.fromMap(x as Map<String, dynamic>),
        ),
      ),
      removedRooms: List<Room>.from(
        (map['removedRooms'] as List<int>).map<Room>(
          (x) => Room.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
