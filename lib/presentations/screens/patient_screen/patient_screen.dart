import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/data/models/patient_model.dart';
import 'package:doctor_test/data/models/room_model.dart';
import 'package:doctor_test/presentations/screens/patient_screen/create_patient_screen.dart';
import 'package:doctor_test/presentations/screens/patient_screen/widgets/custom_search_patient_bar.dart';
import 'package:doctor_test/presentations/screens/patient_screen/widgets/patient_tile.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatefulWidget {
  final Room room;
  const PatientScreen({super.key, required this.room});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: PatientProvider.getPatients(room: widget.room),
      builder: (context, snapshot) {
        final patients = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(
                  child: Text('Đã có lỗi xảy ra :> ai đó hãy cíu tôi đi'));
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Phòng ${widget.room.roomId}'),
                  actions: [
                    _createPatient(context),
                    _searchPatient(context),
                  ],
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text('Tổng số bệnh nhân: ${patients!.length}'),
                    ),
                    _listPatient(patients),
                  ],
                ),
              );
            }
        }
      },
    );
  }

  Expanded _listPatient(List<Patient> patients) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Padding(
            padding: const EdgeInsets.all(8),
            child: PatientTile(room: widget.room, patient: patient),
          );
        },
      ),
    );
  }

  IconButton _createPatient(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePatientScreen(room: widget.room),
            ),
          );
        },
        icon: const Icon(Icons.add));
  }

  IconButton _searchPatient(BuildContext context) {
    return IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: CustomSearchPatientDelegate(widget.room),
          );
        },
        icon: const Icon(Icons.search));
  }
}
