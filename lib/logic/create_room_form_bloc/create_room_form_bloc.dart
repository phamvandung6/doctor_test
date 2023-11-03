import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateRoomFormBloc extends FormBloc<String, String> {
  final roomName = TextFieldBloc();
  final roomId = TextFieldBloc();

  CreateRoomFormBloc() {
    addFieldBlocs(fieldBlocs: [
      roomName,
      roomId,
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

