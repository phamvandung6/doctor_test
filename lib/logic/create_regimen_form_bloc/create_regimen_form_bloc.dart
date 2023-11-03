import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateRegimenFormBloc extends FormBloc<String, String> {
  final listRegimen = SelectFieldBloc(
    items: ['TPN', 'Sonde', 'Truyền miệng', 'ĐTĐ nhịn ăn'],
  );

  CreateRegimenFormBloc() {
    addFieldBlocs(fieldBlocs: [
      listRegimen,
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
