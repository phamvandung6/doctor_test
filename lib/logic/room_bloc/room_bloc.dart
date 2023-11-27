import 'package:bloc/bloc.dart';
import 'package:doctor_test/models/patient_model.dart';
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
  }

  void _onSearchRoom(SearchRoom event, Emitter<RoomState> emit) async {
    List<Room> allRooms = [];
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
    List<Room> removedRooms = [];
    await FirestoreRepository.getRooms().then((value) {
      for (var room in value) {
        allRooms.add(room);
      }
    });

    emit(RoomState(
      allRooms: allRooms,
    ));
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
