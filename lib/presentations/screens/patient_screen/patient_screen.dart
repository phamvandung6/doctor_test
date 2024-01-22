import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/models/room_model.dart';
import 'package:doctor_test/presentations/screens/patient_screen/adding_data.dart';
import 'package:flutter/material.dart';

import '../patient_home_page/patient_home_page.dart';

class PatientScreen extends StatelessWidget {
  final Room room;
  const PatientScreen({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var roomBloc = context.read<RoomBloc>().state.chosenRoom;
    return BlocProvider<PatientBloc>(
      create: (context) => PatientBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Phòng ${room.roomName}'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WizardForm()),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: context.watch<PatientBloc>().state.allPatients.length,
          itemBuilder: (context, index) {
            final patient =
                context.watch<PatientBloc>().state.allPatients.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  context
                      .read<PatientBloc>()
                      .add(ChoosePatient(chosenPatient: patient));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientHomePage(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(width: 1),
                ),
                title: Text('Tên bệnh nhân: ${patient.name}'),
                subtitle: Text('Id bệnh nhân: ${patient.id}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Xác nhận xóa'),
                          content: Text(
                              'Bạn có chắc chắn muốn xóa bệnh nhân ${patient.name} không?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context
                                    .read<PatientBloc>()
                                    .add(DeletePatient(patient: patient));
                                context
                                    .read<PatientBloc>()
                                    .add(GetAllPatients(room: room));
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
    );
  }
}
