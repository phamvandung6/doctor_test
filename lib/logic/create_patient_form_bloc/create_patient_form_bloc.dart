import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/data/models/patient_model.dart';
import 'package:doctor_test/data/models/room_model.dart';
import 'package:doctor_test/logic/create_patient_form_bloc/patient_validator.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreatePatientFormBloc extends FormBloc<String, String> {
  final id = TextFieldBloc(validators: [PatientValidators.required]);
  final name = TextFieldBloc(validators: [PatientValidators.required]);
  final weight = TextFieldBloc(validators: [PatientValidators.required]);
  final height = TextFieldBloc(validators: [PatientValidators.required]);
  final birthday = InputFieldBloc<DateTime, dynamic>(
    name: 'birthday',
    initialValue: DateTime.now(),
  );
  final address = TextFieldBloc(validators: [PatientValidators.required]);
  final phone = TextFieldBloc(validators: [PatientValidators.required]);
  final gender = TextFieldBloc(validators: [PatientValidators.required]);

  CreatePatientFormBloc({
    required Room room,
  }) : _room = room {
    addFieldBlocs(fieldBlocs: [
      id,
      name,
      weight,
      height,
      birthday,
      address,
      phone,
      gender,
    ]);
  }
  final Room _room;

  //vì để tạo bệnh bắt buộc phải có roomId nên em không xử lí logic tạo bệnh nhân
  // ở đây mà xử lí ở create_patient_screen
  @override
  void onSubmitting() async {
    try {
      var patient = Patient(
        id: id.value,
        name: name.value,
        weight: weight.valueToDouble!,
        height: weight.valueToDouble!,
        birthday: Timestamp.fromDate(birthday.value),
        address: address.value,
        phone: phone.value,
        gender: gender.value,
      );
      final isIdExist =
          await PatientProvider.isExistId(room: _room, id: id.value);
      if (isIdExist) {
        emitFailure(failureResponse: 'Id bệnh nhân này đã tồn tại');
      } else {
        PatientProvider.createPatient(room: _room, patient: patient);
      }
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
