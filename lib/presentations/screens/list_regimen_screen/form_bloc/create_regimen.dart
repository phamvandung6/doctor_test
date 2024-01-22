import 'package:doctor_test/presentations/screens/list_regimen_screen/form_bloc/create_regimen_form_bloc.dart';
import 'package:doctor_test/utils/loading_dialog.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:flutter/material.dart';

import '../../../../models/patient_model.dart';
import '../../../../models/room_model.dart';

class CreateRegimenForm extends StatelessWidget {
  const CreateRegimenForm(
      {super.key, required this.room, required this.patient});

  final Room room;
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateRegimenFormBloc(room: room, patient: patient),
      child: Builder(builder: (context) {
        final formBloc = BlocProvider.of<CreateRegimenFormBloc>(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Tạo phòng mới')),
          body: FormBlocListener<CreateRegimenFormBloc, String, String>(
            onSubmitting: (context, state) async {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
              Navigator.pop(context);
            },
            onFailure: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failureResponse.toString())));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 130, left: 12, right: 12),
              child: Column(
                children: [
                  DropdownFieldBlocBuilder(
                    selectFieldBloc: formBloc.regimen,
                    itemBuilder: (context, value) => FieldItem(
                      child: Text(value),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        formBloc.submit();
                      },
                      child: const Text('Tạo')),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
