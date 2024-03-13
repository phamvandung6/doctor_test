import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/patient_home_page/patient_home_page.dart';
import 'package:doctor_test/presentations/screens/patient_screen/create_room_screen.dart';
import 'package:doctor_test/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/room_model.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    PatientBloc patientBloc = BlocProvider.of<PatientBloc>(context);
    RoomBloc roomBloc = BlocProvider.of<RoomBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomBloc>(
          create: (context) => RoomBloc(),
        ),
        BlocProvider<PatientBloc>(
          create: (context) => PatientBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    context
                        .read<RoomBloc>()
                        .add(const ChooseRoom(chosenRoom: Room()));
                  },
                  icon: const Icon(Icons.arrow_back_sharp));
            },
          ),
          title: BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) {
              if (state.chosenRoom == const Room(roomId: '', roomName: '')) {
                return const Text('Danh sách phòng bệnh');
              } else {
                return Text('Phòng ${state.chosenRoom.roomName}');
              }
            },
          ),
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
                onChanged: (value) {
                  context.read<RoomBloc>().add(SearchRoom(search: value));
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Tìm phòng',
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            BlocBuilder<RoomBloc, RoomState>(builder: (context, state) {
              context.read<RoomBloc>().add(GetAllRooms());
              if (state.chosenRoom == const Room()) {
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.allRooms.length,
                    itemBuilder: (context, index) {
                      final room = state.allRooms[index];
                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ReusableList(
                            titleName: 'Tên phòng: ${room.roomName}',
                            subtitleName: 'Id phòng: ${room.roomId}',
                            onPressed: () {
                              context
                                  .read<RoomBloc>()
                                  .add(ChooseRoom(chosenRoom: room));
                              roomBloc.add(ChooseRoom(chosenRoom: room));
                            },
                          ));
                    },
                  ),
                );
              } else {
                Room chosenRoom = state.chosenRoom;
                return BlocBuilder<PatientBloc, PatientState>(
                    builder: (context, state) {
                  context
                      .read<PatientBloc>()
                      .add(GetAllPatients(room: chosenRoom));
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.allPatients.length,
                      itemBuilder: (context, index) {
                        final patient = state.allPatients[index];
                        return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ReusableList(
                              titleName: 'Tên bệnh nhân: ${patient.name}',
                              subtitleName: 'Id bệnh nhân: ${patient.id}',
                              onPressed: () {
                                patientBloc
                                    .add(ChoosePatient(chosenPatient: patient));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PatientHomePage(),
                                  ),
                                );
                              },
                            ));
                      },
                    ),
                  );
                });
              }
            }),
          ],
        ),
      ),
    );
  }
}
