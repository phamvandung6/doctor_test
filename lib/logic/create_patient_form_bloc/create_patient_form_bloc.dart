import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreatePatientFormBloc extends FormBloc<String, String> {
  final patientName = TextFieldBloc();
  final patientId = TextFieldBloc();

  CreatePatientFormBloc() {
    addFieldBlocs(fieldBlocs: [
      patientName,
      patientId,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}

