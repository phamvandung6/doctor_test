import 'package:doctor_test/presentations/screens/patient_screen/patient_home_page/list_regimen_screen/create_regimen.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/model_export.dart';

class ListRegimen extends StatelessWidget {
  const ListRegimen({
    super.key,
    required this.room,
    required this.patient,
  });

  final Room room;
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Column(
          children: [
            const Text('Helloworld'),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateRegimenForm(room: room, patient: patient);
                  }));
                },
                child: const Text("Tạo phác đồ mới")),
          ],
        ),
      ),
    );
  }
}
