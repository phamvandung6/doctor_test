import 'dart:async';

import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/utils/enums/enum_to_enum.dart';

class CreateRegimenFormBloc extends FormBloc<String, String> {
  final regimen = SelectFieldBloc(items: ['TPN', 'Sonde']);

  CreateRegimenFormBloc({required Room room, required Patient patient})
      : _room = room,
        _patient = patient {
    addFieldBlocs(fieldBlocs: [
      regimen,
    ]);
  }
  final Room _room;
  final Patient _patient;

  @override
  FutureOr<void> onSubmitting() {
    //   var patient = Patient(
    //     id: _patient.id,
    //     name: _patient.name,
    //     weight: _patient.weight,
    //     height: _patient.height,
    //     birthday: _patient.birthday,
    //     address: _patient.address,
    //     phone: _patient.phone,
    //     gender: _patient.gender,
    //   );

    // PatientProvider.updatePatient(room: _room, patient: patient);
    emitSuccess(canSubmitAgain: true);
  }
}
