import 'dart:async';

import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/logic/export_bloc.dart';

class CreateProcedureFormBloc extends FormBloc<String, String> {
  final regimen = SelectFieldBloc(items: ['TPN', 'Sonde']);

  CreateProcedureFormBloc({required Room room, required Patient patient})
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
    var procedure = Procedure(
      procedureType: regimen.value!,
      currentProcedureId: DateTime.now().toString(),
    );
    PatientProvider.createProcedure(
        room: _room, patient: _patient, procedure: procedure);
    emitSuccess(canSubmitAgain: true);
  }
}
