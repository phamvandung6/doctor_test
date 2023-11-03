import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/patient_screen/create_room_screen.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_screen.dart';
import 'package:doctor_test/utils/guid_gen.dart';
import 'package:flutter/material.dart';
import 'package:doctor_test/models/room_model.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        final roomBloc = context.read<RoomBloc>();
        roomBloc.add(GetAllRooms());
        return Scaffold(
          appBar: AppBar(
            title: const Text('Danh sách phòng bệnh'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateRoomScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  // onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Tìm phòng',
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.allRooms.length,
                  itemBuilder: (context, index) {
                    final room = state.allRooms[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientScreen(room: room),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(width: 1),
                        ),
                        title: Text('Tên phòng: ${room.roomName}'),
                        subtitle: Text('Id phòng: ${room.roomId}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Xác nhận xóa'),
                                  content: Text(
                                      'Bạn có chắc chắn muốn xóa phòng ${room.roomName} không'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<RoomBloc>()
                                            .add(DeleteRoom(room: room));
                                        context
                                            .read<RoomBloc>()
                                            .add(GetAllRooms());
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
