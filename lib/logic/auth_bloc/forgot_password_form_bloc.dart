import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ForgotPasswordFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  ForgotPasswordFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
      ],
    );
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.value);
      emitSuccess();
    } on Exception catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
