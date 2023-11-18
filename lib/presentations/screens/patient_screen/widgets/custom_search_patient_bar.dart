import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/data/models/patient_model.dart';
import 'package:doctor_test/data/models/room_model.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_screen.dart';
import 'package:flutter/material.dart';

class CustomSearchPatientDelegate extends SearchDelegate {
  final Room room;

  CustomSearchPatientDelegate(this.room);

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
    Stream<List<Patient>> matchQuery = PatientProvider.getPatientsById(
      roomId: room.roomId,
      patientId: query,
    );
    return StreamBuilder<List<Patient>>(
      stream: matchQuery,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final patients = snapshot.data!;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return _roomTile(context, patient);
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
    Stream<List<Patient>> matchQuery = PatientProvider.getPatients(room: room);
    return StreamBuilder<List<Patient>>(
      stream: matchQuery,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final patients = snapshot.data!;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return _roomTile(context, patient);
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

  Padding _roomTile(BuildContext context, Patient patient) {
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
          child: Text(patient.id),
        ),
        title: Text('Tên bệnh nhân: ${patient.name}'),
        subtitle: Text('Id bệnh nhân: ${patient.id}'),
      ),
    );
  }
}
