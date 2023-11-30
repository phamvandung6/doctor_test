import 'package:doctor_test/data/data_provider/room_provider.dart';
import 'package:doctor_test/data/models/room_model.dart';
import 'package:doctor_test/logic/create_room_form_bloc/room_validator.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateRoomFormBloc extends FormBloc<String, String> {
  final roomName = TextFieldBloc(validators: [
    RoomValidators.required,
  ]);
  final roomId = TextFieldBloc(validators: [
    RoomValidators.required,
  ]);

  CreateRoomFormBloc() {
    addFieldBlocs(fieldBlocs: [
      roomName,
      roomId,
    ]);
  }

  // //to map<String, dynamic> factory
  // factory CreateRoomFormBloc.fromMap(Map<String, dynamic> map) {
  //   return CreateRoomFormBloc()
  //     ..roomId.updateValue(map['roomId'])
  //     ..roomName.updateValue(map['roomName']);
  // }
  // //to map<String, dynamic>
  // Map<String, dynamic> toMap() {
  //   return {
  //     'roomId': roomId.value,
  //     'roomName': roomName.value,
  //   };
  // }

  // có bug ở đây. Khi mình không điền gì vào mà ấn tạo phòng thì nó xứ xoay vòng vòng mãi
  @override
  void onSubmitting() async {
    final id = roomId.value;
    try {
      final isIdExist = await RoomValidators.isExistId(id);
      if (isIdExist) {
        roomId.addFieldError('ID phòng này đã tồn tại');
        emitFailure(failureResponse: 'Phòng này đã tồn tại');
      } else {
        RoomProvider.createRoom(Room(
          roomId: roomId.value,
          roomName: roomName.value,
        ));
      }
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: 'Có lỗi đã xảy ra');
    }
  }
}
