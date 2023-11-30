import 'package:doctor_test/data/models/model_export.dart';
import 'package:flutter/material.dart';

import 'list_regimen_screen/list_regimen.dart';
import 'patient_profile/patient_profile.dart';
import 'treatment/treatment.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key, required this.patient, required this.room});

  final Patient patient;
  final Room room;
  @override
  State<PatientHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ bệnh nhân'),
          bottom: TabBar(
            onTap: (selectedIndex) {},
            tabs: const [
              Tab(
                child: Text(
                  'Điều trị',
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'Danh sách phác đồ',
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'Hồ sơ bệnh nhân',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Treatment(),
            ListRegimen(room: widget.room, patient: widget.patient),
            PatientProfile(widget: widget)
          ],
        ),
      ),
    );
  }
}
