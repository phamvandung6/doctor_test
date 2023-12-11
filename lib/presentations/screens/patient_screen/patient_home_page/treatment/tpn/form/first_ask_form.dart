import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_test/data/data_provider/procedure_provider/tpn_provider.dart';
import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_home_page/treatment/tpn/form_bloc/first_ask_form_bloc.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:doctor_test/utils/loading_dialog.dart';
import 'package:flutter/material.dart';

class FirstAskForm extends StatelessWidget {
  const FirstAskForm({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirstAskFormBloc(
        patient: patient,
      ),
      child: Builder(
        builder: (context) {
          final formBloc = context.read<FirstAskFormBloc>();
          return FormBlocListener<FirstAskFormBloc, String, String>(
            onSubmitting: (context, state) async {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              // LoadingDialog.show(context);

              LoadingDialog.hide(context);
              // Navigator.pop(context);
            },
            onFailure: (context, state) {
              // LoadingDialog.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failureResponse.toString())));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  RadioButtonGroupFieldBlocBuilder(
                    selectFieldBloc: formBloc.yesOrNoInsulin,
                    itemBuilder: (context, value) => FieldItem(
                        child:
                            Text(value[0].toUpperCase() + value.substring(1))),
                    decoration: const InputDecoration(
                      labelText: 'Bệnh nhân có tiền sử tiêm Insulin không?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFieldBlocBuilder(
                    textFieldBloc: formBloc.glucose,
                    decoration: const InputDecoration(
                      labelText: 'Nhập Glucose (mmol/l)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<TpnBloc>().add(const TPNStatusChange(
                            status: TPNStatus.treatmening));

                        formBloc.submit();
                      },
                      child: const Text('Tiếp tục'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
