part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}
class ChooseRoom extends RoomEvent {
  final Room chosenRoom;
  const ChooseRoom({
    required this.chosenRoom,
  });

  @override
  List<Object> get props => [chosenRoom];
}

class SearchRoom extends RoomEvent {
  final String search;
  const SearchRoom({
    required this.search,
  });

  @override
  List<Object> get props => [search];
}

class GetAllRooms extends RoomEvent {
  @override
  List<Object> get props => [];
}

class AddRoom extends RoomEvent {
  final Room room;
  const AddRoom({
    required this.room,
  });

  @override
  List<Object> get props => [room];
}

class RemoveRoom extends RoomEvent {
  final Room room;
  const RemoveRoom({
    required this.room,
  });

  @override
  List<Object> get props => [room];
}

class DeleteRoom extends RoomEvent {
  final Room room;
  const DeleteRoom({
    required this.room,
  });

  @override
  List<Object> get props => [room];
}

//3rd
class RestoreRoom extends RoomEvent {
  final Room room;
  const RestoreRoom({
    required this.room,
  });

  @override
  List<Object> get props => [room];
}

// //4th
class DeleteAllRooms extends RoomEvent {}
