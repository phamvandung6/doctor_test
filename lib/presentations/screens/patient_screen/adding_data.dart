import 'package:doctor_test/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../logic/create_patient_form_bloc/wizard_creation_bloc.dart';
import '../../../logic/patient_bloc/patient_bloc.dart';
import '../../../utils/popup.dart';

class WizardForm extends StatefulWidget {
  final Room room;
  const WizardForm({Key? key, required this.room}) : super(key: key);

  @override
  State<WizardForm> createState() => _WizardFormState();
}

class _WizardFormState extends State<WizardForm> {
  final _type = StepperType.vertical;

  // void _toggleType() {
  //   setState(() {
  //     if (_type == StepperType.horizontal) {
  //       _type = StepperType.vertical;
  //     } else {
  //       _type = StepperType.horizontal;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WizardFormBloc(room: widget.room.roomId),
      child: Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('Tạo hồ sơ'),
                // actions: <Widget>[
                //   IconButton(
                //       icon: Icon(_type == StepperType.horizontal
                //           ? Icons.swap_vert
                //           : Icons.swap_horiz),
                //       onPressed: _toggleType)
                // ],
              ),
              body: SafeArea(
                child: FormBlocListener<WizardFormBloc, String, String>(
                  onSubmitting: (context, state) => LoadingDialog.show(context),
                  onSubmissionFailed: (context, state) =>
                      LoadingDialog.hide(context),
                  onSuccess: (context, state) {
                    LoadingDialog.hide(context);

                    if (state.stepCompleted == state.lastStep) {
                      showdialog(context, "Tạo hồ sơ", "thành công");
                      var patient = context.read<WizardFormBloc>().patient;
                      context
                          .read<PatientBloc>()
                          .add(AddPatient(patient: patient));
                      context
                          .read<PatientBloc>()
                          .add(GetAllPatients(room: widget.room));
                      Navigator.pop(context);
                    }
                  },
                  onFailure: (context, state) {
                    LoadingDialog.hide(context);
                    showdialog(context, "Tạo hồ sơ", state.failureResponse!);
                  },
                  child: StepperFormBlocBuilder<WizardFormBloc>(
                    formBloc: context.read<WizardFormBloc>(),
                    type: _type,
                    physics: const ClampingScrollPhysics(),
                    stepsBuilder: (formBloc) {
                      return [
                        _accountStep(formBloc!),
                        _personalStep(formBloc),
                        _contactStep(formBloc),
                        _genderBirthdateStep(formBloc),
                      ];
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FormBlocStep _accountStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: const Text('Account'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.name,
            keyboardType: TextInputType.name,
            enableOnlyWhenFormBlocCanSubmit: true,
            decoration: const InputDecoration(
              labelText: 'Tên',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
              textFieldBloc: wizardFormBloc.id,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'ID', prefixIcon: Icon(FontAwesomeIcons.idCard))),
        ],
      ),
    );
  }

  FormBlocStep _personalStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: const Text('Personal'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.height,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: 'Chiều cao',
                prefixIcon: Icon(Icons.line_weight),
                hintText: 'cm'),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.weight,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: 'Cân nặng',
                prefixIcon: Icon(Icons.height),
                hintText: 'kg'),
          ),
        ],
      ),
    );
  }

  FormBlocStep _contactStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: const Text('Social'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
              textFieldBloc: wizardFormBloc.address,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Địa chỉ', prefixIcon: Icon(Icons.location_on))),
          TextFieldBlocBuilder(
              textFieldBloc: wizardFormBloc.phoneNumber,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Số điện thoại', prefixIcon: Icon(Icons.phone))),
        ],
      ),
    );
  }

  FormBlocStep _genderBirthdateStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: const Text('Giới tính và ngày sinh'),
      content: Column(
        children: <Widget>[
          RadioButtonGroupFieldBlocBuilder<String>(
            selectFieldBloc: wizardFormBloc.gender,
            itemBuilder: (context, value) => FieldItem(
              child: Text(value),
            ),
            decoration: const InputDecoration(
              labelText: 'Giới tính',
              prefixIcon: SizedBox(),
            ),
          ),
          DateTimeFieldBlocBuilder(
            dateTimeFieldBloc: wizardFormBloc.birthDate,
            firstDate: DateTime(1900),
            initialDate: DateTime(2000),
            lastDate: DateTime(2100),
            format: DateFormat('dd-MM-yyyy'),
            decoration: const InputDecoration(
              labelText: 'Ngày sinh',
              prefixIcon: Icon(Icons.cake),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
