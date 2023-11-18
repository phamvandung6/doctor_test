import 'package:doctor_test/data/data_provider/room_provider.dart';
import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/presentations/screens/patient_screen/create_room_screen.dart';
import 'package:doctor_test/presentations/screens/patient_screen/widgets/custom_search_room_bar.dart';
import 'package:doctor_test/presentations/screens/patient_screen/widgets/room_tile.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RoomProvider.getRooms(),
      builder: (context, snapshot) {
        final rooms = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Đã có lỗi xảy ra'));
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Danh sách phòng bệnh'),
                  actions: [
                    _createRoom(context),
                    _searchRoom(context),
                  ],
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text('Tổng số phòng bệnh: ${rooms!.length}'),
                    ),
                    _listRoom(rooms),
                  ],
                ),
              );
            }
        }
      },
    );
  }

  Expanded _listRoom(List<Room> rooms) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Padding(
            padding: const EdgeInsets.all(8),
            child: RoomTile(room: room),
          );
        },
      ),
    );
  }

  IconButton _searchRoom(BuildContext context) {
    return IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: CustomSearchRoomDelegate(),
          );
        },
        icon: const Icon(Icons.search));
  }

  IconButton _createRoom(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateRoomScreen()),
          );
        },
        icon: const Icon(Icons.add));
  }
}
