import 'package:doctor_test/data/data_provider/room_provider.dart';
import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_screen.dart';
import 'package:doctor_test/utils/popup_menu.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientScreen(room: room),
          ),
        );
      },
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadiusDirectional.circular(23),
      // ),
      tileColor: const Color.fromARGB(255, 255, 255, 255),
      leading: CircleAvatar(
        backgroundColor: const Color(0xffA6E3E9),
        child: Text(room.roomName),
      ),
      title: Text('Tên phòng: ${room.roomName}'),
      subtitle: Text('Id phòng: ${room.roomId}'),
      trailing: PopupMenu(
        deleteCallBack: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Xác nhận xóa'),
                content: Text(
                  'Bạn có chắc chắn muốn xóa ${room.roomName} không?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      RoomProvider.deleteRoom(room: room);
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
