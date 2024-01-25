import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/room_bloc/room_bloc.dart';
import '../models/patient_model.dart';
import '../models/room_model.dart';

class ReusableList extends StatelessWidget {
  const ReusableList({
    Key? key,
    required this.titleName,
    required this.subtitleName,
    required this.onPressed,
  }) : super(key: key);

  final String titleName;
  final String subtitleName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(width: 1),
      ),
      title: Text(titleName),
      subtitle: Text(subtitleName),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Xác nhận xóa'),
                content: const Text('Bạn có chắc chắn muốn xóakhông'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // context
                      //     .read<RoomBloc>()
                      //     .add(DeleteRoom(room: room));
                      // context
                      //     .read<RoomBloc>()
                      //     .add(GetAllRooms());
                      Navigator.pop(context);
                    },
                    child: const Text('Xóa'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Hủy'),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

Container inputBox(String text, Function(dynamic value)? onPressed) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black)),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: text,
      ),
      keyboardType: TextInputType.number,
      onSubmitted: onPressed,
    ),
  );
}

Container textBox(String text) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
      // gradient: Gradient(colors: )
    ),
    child: Text(text),
  );
}

Expanded listRoom(List<Room> rooms, BuildContext context) {
  return Expanded(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Padding(
            padding: const EdgeInsets.all(8),
            child: ReusableList(
              titleName: 'Tên phòng: ${room.roomName}',
              subtitleName: 'Id phòng: ${room.roomId}',
              onPressed: () {
                context.read<RoomBloc>().add(ChooseRoom(chosenRoom: room));
              },
            ));
      },
    ),
  );
}

Expanded listPatient(List<Patient> patients, BuildContext context) {
  return Expanded(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return Padding(
            padding: const EdgeInsets.all(8),
            child: ReusableList(
              titleName: 'Tên bệnh nhân: ${patient.name}',
              subtitleName: 'Id bệnh nhân: ${patient.id}',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PatientScreen(room: null,),
                //   ),
                // );
              },
            ));
      },
    ),
  );
}
