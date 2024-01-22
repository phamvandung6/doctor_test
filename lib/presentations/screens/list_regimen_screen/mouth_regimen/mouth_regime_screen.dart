import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/logic/regimen_bloc/mouth_bloc/mouth_bloc.dart';
import 'package:doctor_test/presentations/screens/list_regimen_screen/time_check.dart';
import 'package:flutter/material.dart';

import '../../../../utils/enums/enum.dart';
import '../../../../utils/enums/enum_to_string.dart';

class MouthRegimenScreen extends StatefulWidget {
  const MouthRegimenScreen({Key? key}) : super(key: key);
  State<MouthRegimenScreen> createState() => _MouthRegimenScreenState();
}

class _MouthRegimenScreenState extends State<MouthRegimenScreen> {
  List<InsulinType> insulinType = InsulinType.values;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MouthBloc(),
      child: Expanded(
          child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: const Text('Tạm ngưng các thuốc hạ đường huyết'),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: const Text(
                'Truyền glucose 10% 500ml pha truyền 5UI Actrapid hoặc Nutriflex pha truyền 9UI Actrapid'),
          ),
          BlocBuilder<MouthBloc, MouthState>(builder: (context, state) {
            if (context.read<MouthBloc>().state.regimenStatus ==
                RegimenStatus.done) {
              return Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Text('Đạt mục tiêu'),
              );
            } else if (state.regimenStatus == RegimenStatus.givingInsulin) {
              if (state.glucoseLevel > 8.3 && state.glucoseLevel <= 11.1) {
                return Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Text(
                      'Truyền dung dịch ${EnumToString.enumToString(InsulinType.actrapid)} 2UI'),
                );
              } else {
                return Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Text(
                      'Truyền dung dịch ${EnumToString.enumToString(InsulinType.actrapid)} 4UI'),
                );
              }
            } else if (state.regimenStatus == RegimenStatus.checkingGlucose) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nhập đường huyết',
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    context
                        .read<MouthBloc>()
                        .add(CheckGlucose(glucoseLevel: double.parse(value)));
                  },
                ),
              );
            } else {
              return Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TimeCheck(isCheck: false, time: DateTime.now()),
              );
            }
          })
        ],
      )),
    );
  }
}
