import 'package:bloc/bloc.dart';
import 'package:doctor_test/models/room_model.dart';
import 'package:doctor_test/repositories/firebase_repository.dart';
import 'package:equatable/equatable.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(const RoomState()) {
    on<AddRoom>(_onAddRoom);
    on<GetAllRooms>(_onGetAllRooms);
    on<DeleteRoom>(_onDeleteRoom);
    on<RemoveRoom>(_onRemoveRoom);
    on<RestoreRoom>(_onRestoreRoom);
    on<SearchRoom>(_onSearchRoom);
    on<ChooseRoom>(_onChooseRoom);
  }
  void _onChooseRoom(ChooseRoom event, Emitter<RoomState> emit) {
    Room chosenRoom = event.chosenRoom;
    emit(state.copyWith(chosenRoom: chosenRoom));
    // print(state.chosenRoom);
  }

  // sau này sẽ cải tiến tìm kiếm ko theo thời gian thực.
  void _onSearchRoom(SearchRoom event, Emitter<RoomState> emit) async {
    List<Room> allRooms = [];
    if (event.search == '') {
      emit(state.copyWith(allRooms: []));
      return;
    }
    await FirestoreRepository.getRoom(id: event.search).then((value) {
      allRooms.add(value);
    });
    emit(state.copyWith(allRooms: allRooms));
  }

  void _onAddRoom(AddRoom event, Emitter<RoomState> emit) async {
    await FirestoreRepository.createRoom(room: event.room);
  }

  void _onGetAllRooms(GetAllRooms event, Emitter<RoomState> emit) async {
    List<Room> allRooms = [];
    // List<Room> removedRooms = [];
    await FirestoreRepository.getRooms().then((value) {
      for (var room in value) {
        allRooms.add(room);
      }
    });
    emit(state.copyWith(allRooms: allRooms));
  }

  void _onDeleteRoom(DeleteRoom event, Emitter<RoomState> emit) async {
    await FirestoreRepository.deleteRoom(room: event.room);
  }

  void _onRemoveRoom(RemoveRoom event, Emitter<RoomState> emit) async {
    Room removedRoom = event.room.copyWith(isDeleted: true);
    await FirestoreRepository.updateRoom(room: removedRoom);
  }

  void _onRestoreRoom(RestoreRoom event, Emitter<RoomState> emit) async {
    Room restoredRoom = event.room.copyWith(
      isDeleted: false,
    );
    await FirestoreRepository.updateRoom(room: restoredRoom);
  }
}
