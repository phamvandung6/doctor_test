import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreatePatientFormBloc extends FormBloc<String, String> {
  final id = TextFieldBloc();
  final name = TextFieldBloc();
  final weight = TextFieldBloc();
  final height = TextFieldBloc();
  final birthday = InputFieldBloc<DateTime, dynamic>(
    name: 'birthday',
    initialValue: DateTime.now(),
  );
  final address = TextFieldBloc();
  final phone = TextFieldBloc();
  final gender = TextFieldBloc();

  CreatePatientFormBloc() {
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


  //vì để tạo bệnh bắt buộc phải có roomId nên em không xử lí logic tạo bệnh nhân ở đây mà xử lí ở create_patient_screen
  @override
  void onSubmitting() async {
    try {
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
