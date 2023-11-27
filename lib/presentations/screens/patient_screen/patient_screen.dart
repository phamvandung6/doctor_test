import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/models/room_model.dart';
import 'package:doctor_test/presentations/screens/patient_screen/adding_data.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  final Room room;
  const PatientScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        final patientBloc = context.read<PatientBloc>();
        patientBloc.add(GetAllPatients(room: room));
        return Scaffold(
          appBar: AppBar(
            title: Text('Phòng ${room.roomName}'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WizardForm(room: room)),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: state.allPatients.length,
            itemBuilder: (context, index) {
              final patient = state.allPatients[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () {},
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
                                  patientBloc
                                      .add(DeletePatient(patient: patient));
                                  patientBloc.add(GetAllPatients(room: room));
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
        );
      },
    );
  }
}
