import 'package:doctor_test/data/models/model_export.dart';
import 'package:flutter/material.dart';

import 'list_procedure_screen/list_procedure.dart';
import 'patient_profile/patient_profile.dart';
import 'treatment/tpn/tpn_treatment.dart';

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
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ bệnh nhân'),
          bottom: TabBar(
            onTap: (index) {},
            tabs: const [
              Tab(
                child: Text(
                  'Phác đồ đang điều trị',
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
            ListProcedure(
              room: widget.room,
              patient: widget.patient,
            ),
            PatientProfile(widget: widget)
          ],
        ),
      ),
    );
  }
}
