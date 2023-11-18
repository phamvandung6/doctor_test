import 'package:doctor_test/data/data_provider/room_provider.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_screen.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/model_export.dart';

class CustomSearchRoomDelegate extends SearchDelegate {
  Stream<List<Room>> searchTerms = RoomProvider.getRooms();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Stream<List<Room>> matchQuery = RoomProvider.getRoomsById(query);
    return StreamBuilder<List<Room>>(
      stream: matchQuery,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final rooms = snapshot.data!;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return _roomTile(context, room);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Đã có lỗi xảy ra'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Stream<List<Room>> matchQuery = RoomProvider.getRooms();
    return StreamBuilder<List<Room>>(
      stream: matchQuery,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final rooms = snapshot.data!;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return _roomTile(context, room);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Đã có lỗi xảy ra'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Padding _roomTile(BuildContext context, Room room) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          borderRadius: BorderRadiusDirectional.circular(23),
        ),
        tileColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: const Color(0xffA6E3E9),
          child: Text(room.roomName),
        ),
        title: Text('Tên phòng: ${room.roomName}'),
        subtitle: Text('Id phòng: ${room.roomId}'),
      ),
    );
  }
}
