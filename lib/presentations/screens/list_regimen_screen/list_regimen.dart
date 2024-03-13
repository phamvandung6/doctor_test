import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/list_regimen_screen/create_regimen2.dart';
import 'package:doctor_test/presentations/screens/list_regimen_screen/mouth_regimen/mouth_regime_screen.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:flutter/material.dart';

import '../../../models/room_model.dart';

class ListRegimen extends StatelessWidget {
  const ListRegimen({
    super.key,
    required this.room,
  });

  final Room room;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: BlocProvider.value(
          value: BlocProvider.of<PatientBloc>(context),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CreateRegimen2();
                    }));
                  },
                  child: const Text("Tạo phác đồ mới")),
              BlocBuilder<PatientBloc, PatientState>(
                builder: (context, state) {
                  if (state.chosenPatient.procedureType ==
                      ProcedureType.unknown) {
                    return const Text('Chưa có phác đồ');
                  } else if (state.chosenPatient.procedureType ==
                      ProcedureType.mouth) {
                    return const MouthRegimenScreen();
                  } else {
                    return const Text('Chưa có phác đồ');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
