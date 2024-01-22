import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../models/patient_model.dart';

class WizardFormBloc extends FormBloc<String, String> {
  Patient patient = const Patient();
  final name = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final id = TextFieldBloc<String>(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final height = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final weight = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final address = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final phoneNumber = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  final gender = SelectFieldBloc(
    items: ['Nam', 'Nữ'],
  );
  final birthDate = InputFieldBloc<DateTime?, Object>(
    initialValue: null,
    validators: [FieldBlocValidators.required],
  );

  WizardFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [name, id],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [height, weight],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [address, phoneNumber],
    );
    addFieldBlocs(step: 3, fieldBlocs: [gender, birthDate]);
  }

  @override
  void onSubmitting() async {
    if (state.currentStep == 0) {
      patient = patient.copyWith(name: name.value, id: id.value);
      emitSuccess();
    } else if (state.currentStep == 1) {
      patient = patient.copyWith(
          height: double.parse(height.value),
          weight: double.parse(weight.value));
      emitSuccess();
    } else if (state.currentStep == 2) {
      patient =
          patient.copyWith(address: address.value, phone: phoneNumber.value);
      emitSuccess();
    } else if (state.currentStep == 3) {
      patient = patient.copyWith(
          gender: gender.value, birthday: Timestamp.fromDate(birthDate.value!));
      await Future.delayed(const Duration(milliseconds: 500));

      print(patient.toMap());
      emitSuccess();
    }
  }
}
