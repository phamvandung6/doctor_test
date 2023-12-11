import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_home_page/treatment/tpn/form/first_ask_form.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:flutter/material.dart';

class Treatment extends StatelessWidget {
  const Treatment({
    super.key,
    required this.patient,
  });
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TpnBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Điều trị'),
          ),
          body: Column(
            children: [
              const Text('Điều trị cho bệnh nhân'),
              BlocBuilder<TpnBloc, TpnState>(builder: (context, state) {
                if (state.status == TPNStatus.firstAsk) {
                  return FirstAskForm(
                    patient: patient,
                  );
                } else if (state.status == TPNStatus.finish) {
                  return const Text('Chuyển sang hội chẩn để tiếp tục');
                } else {
                  return const Text('Đang điều trị');
                }
              })
              // ElevatedButton(onPressed: () {}, child: const Text('Tiếp tục'))
            ],
          )),
    );
  }
}
