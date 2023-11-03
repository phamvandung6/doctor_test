import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.email,
  ]);
  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      (value) =>
          value.length >= 6 ? null : 'Password must be at least 6 characters',
    ],
  );
  final confirmPassword = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      (value) =>
          value.length >= 6 ? null : 'Password must be at least 6 characters',
    ],
  );

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return 'Must be equal to password';
    };
  }

  RegisterFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
        confirmPassword,
      ],
    );

    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);
  }

  @override
  void onSubmitting() async {
    debugPrint(password.value);
    debugPrint(confirmPassword.value);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.value, password: password.value);
      emitSuccess();
    } on Exception catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
