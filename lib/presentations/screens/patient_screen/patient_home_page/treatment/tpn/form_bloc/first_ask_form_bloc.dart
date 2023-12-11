import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/data/data_provider/procedure_provider/tpn_provider.dart';
import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:doctor_test/utils/form_validator.dart';

import '../../../../../../../data/models/model_export.dart';

class FirstAskFormBloc extends FormBloc<String, String> {
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Có', 'Không'],
  );
  final glucose = TextFieldBloc(validators: [FormValidatorUtils.required]);

  FirstAskFormBloc({
    required Patient patient,
  }) : _patient = patient {
    addFieldBlocs(fieldBlocs: [
      yesOrNoInsulin,
      glucose,
    ]);
  }
  final Patient _patient;

  @override
  FutureOr<void> onSubmitting() {
    try {
      TPNProvider.createTPNProcedure(
          patient: _patient,
          tpnProcedure: TPNModel(
            beginTime: Timestamp.now(),
            medicalActions: const [],
            name: (yesOrNoInsulin.value.toString() == 'Có')
                ? 'YesInsulin'
                : 'NoInsulin',
            // status: TPNStatus.treatmening,
            treatmenStatus: (yesOrNoInsulin.value.toString() == 'Có')
                ? TPNType.yesInsulin
                : TPNType.noInsulin,
          ));
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}
