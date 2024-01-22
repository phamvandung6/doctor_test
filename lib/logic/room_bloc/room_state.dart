part of 'room_bloc.dart';

enum Roomstatus {
  addRoom,
  getAllRooms,
  deleteRoom,
  removeRoom,
  restoreRoom,
  searchRoom,
  chooseRoom,
}

class RoomState extends Equatable {
  //Danh sách tất cả các phòng

  final List<Room> allRooms;
  //Danh sách phòng đã xóa
  final List<Room> removedRooms;
  final Room chosenRoom;
  const RoomState({
    this.allRooms = const <Room>[],
    this.removedRooms = const <Room>[],
    this.chosenRoom = const Room(),
  });
  RoomState copyWith({
    List<Room>? allRooms,
    List<Room>? removedRooms,
    Room? chosenRoom,
  }) {
    return RoomState(
      allRooms: allRooms ?? this.allRooms,
      removedRooms: removedRooms ?? this.removedRooms,
      chosenRoom: chosenRoom ?? this.chosenRoom,
    );
  }

  @override
  List<Object> get props => [allRooms, removedRooms, chosenRoom];
}
