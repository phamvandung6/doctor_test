import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:flutter/material.dart';

import '../../../utils/enums/enum_to_string.dart';

class CreateRegimen2 extends StatefulWidget {
  const CreateRegimen2({super.key});

  @override
  State<CreateRegimen2> createState() => _CreateRegimen2State();
}

class _CreateRegimen2State extends State<CreateRegimen2> {
  ProcedureType dropdownValue = ProcedureType.unknown;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo phác đồ mới'),
      ),
      body: Center(
        child: BlocProvider<PatientBloc>.value(
          value: BlocProvider.of<PatientBloc>(context),
          child: Column(
            children: [
              DropdownButton<ProcedureType>(
                dropdownColor: Colors.white,
                value: dropdownValue,
                onChanged: (ProcedureType? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: ProcedureType.values.map((ProcedureType value) {
                  return DropdownMenuItem<ProcedureType>(
                    value: value,
                    child: Text(EnumToString.enumToString(value)),
                  );
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<PatientBloc>().add(UpdatePatientProcedure(
                        procedureType:
                            EnumToString.enumToString(dropdownValue)));
                    Navigator.pop(context);
                  },
                  child: const Text('Tạo phác đồ mới'))
            ],
          ),
        ),
      ),
    );
  }
}
