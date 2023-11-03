import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/models/patient_model.dart';
import 'package:doctor_test/models/room_model.dart';
import 'package:doctor_test/utils/guid_gen.dart';
import 'package:doctor_test/utils/loading_dialog.dart';
import 'package:flutter/material.dart';

class CreatePatientScreen extends StatelessWidget {
  final Room room;
  const CreatePatientScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePatientFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<CreatePatientFormBloc>(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Tạo bệnh nhân mới')),
            body: FormBlocListener<CreatePatientFormBloc, String, String>(
              onSubmitting: (context, state) {
                var patient = Patient(
                  patientId: formBloc.patientId.value,
                  patientName: formBloc.patientName.value,
                  id: GUIDGen.generate(),
                  patientRoom: room.roomId,
                );
                context.read<PatientBloc>().add(AddPatient(patient: patient));
                context.read<PatientBloc>().add(GetAllPatients(room: room));
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                Navigator.pop(context);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse.toString())));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 130, left: 12, right: 12),
                child: Column(
                  children: [
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.patientName,
                      decoration: InputDecoration(
                        labelText: 'Nhập tên bệnh nhân',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.patientId,
                      decoration: InputDecoration(
                        labelText: 'Nhập id bệnh nhân',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        formBloc.submit();
                      },
                      child: const Text('Thêm'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
