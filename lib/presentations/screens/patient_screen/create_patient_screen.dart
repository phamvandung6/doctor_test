import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/data/models/patient_model.dart';
import 'package:doctor_test/data/models/room_model.dart';
import 'package:doctor_test/utils/loading_dialog.dart';
import 'package:flutter/material.dart';

class CreatePatientScreen extends StatelessWidget {
  final Room room;
  const CreatePatientScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePatientFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<CreatePatientFormBloc>(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Tạo bệnh nhân mới')),
            body: FormBlocListener<CreatePatientFormBloc, String, String>(
              onSubmitting: (context, state) {
                var patient = Patient(
                  id: formBloc.id.value,
                  name: formBloc.name.value,
                  weight: formBloc.weight.valueToDouble!,
                  height: formBloc.weight.valueToDouble!,
                  birthday: formBloc.birthday.value,
                  address: formBloc.address.value,
                  phone: formBloc.phone.value,
                  gender: formBloc.gender.value,
                );
                PatientProvider.createPatient(
                  roomId: room.roomId,
                  patient: patient,
                );
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                Navigator.pop(context);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse.toString())));
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
                  child: Column(
                    children: [
                      _patientNameField(formBloc),
                      _patientIdField(formBloc),
                      _patientWeightField(formBloc),
                      _patientHeightField(formBloc),
                      _patientBirthdayField(formBloc),
                      _patientAddressField(formBloc),
                      _patientPhoneField(formBloc),
                      _patientGenderField(formBloc),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          formBloc.submit();
                        },
                        child: const Text('Thêm'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFieldBlocBuilder _patientGenderField(CreatePatientFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.gender,
      decoration: InputDecoration(
        labelText: 'Giới tính',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _patientPhoneField(CreatePatientFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.phone,
      decoration: InputDecoration(
        labelText: 'Số điện thoại',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _patientAddressField(CreatePatientFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.address,
      decoration: InputDecoration(
        labelText: 'Địa chỉ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  DateTimeFieldBlocBuilder _patientBirthdayField(
      CreatePatientFormBloc formBloc) {
    return DateTimeFieldBlocBuilder(
      dateTimeFieldBloc: formBloc.birthday,
      format: DateFormat('dd-MM-yyyy'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      decoration: const InputDecoration(
        labelText: 'Nhập ngày sinh của bệnh nhân',
        prefixIcon: Icon(Icons.calendar_today),
      ),
    );
  }

  TextFieldBlocBuilder _patientHeightField(CreatePatientFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.height,
      decoration: InputDecoration(
        labelText: 'Nhập chiều cao bệnh nhân',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _patientWeightField(CreatePatientFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.weight,
      decoration: InputDecoration(
        labelText: 'Nhập cân nặng bệnh nhân',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _patientIdField(CreatePatientFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.id,
      decoration: InputDecoration(
        labelText: 'Nhập id bệnh nhân',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _patientNameField(CreatePatientFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.name,
      decoration: InputDecoration(
        labelText: 'Nhập tên bệnh nhân',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
