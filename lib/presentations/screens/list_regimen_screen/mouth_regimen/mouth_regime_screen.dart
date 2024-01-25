import 'dart:async';

import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/logic/regimen_bloc/mouth_bloc/mouth_bloc.dart';
import 'package:doctor_test/presentations/screens/list_regimen_screen/time_check.dart';
import 'package:doctor_test/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/enums/enum.dart';
import '../../../../utils/enums/enum_to_string.dart';

class MouthRegimenScreen extends StatefulWidget {
  const MouthRegimenScreen({Key? key}) : super(key: key);
  @override
  State<MouthRegimenScreen> createState() => _MouthRegimenScreenState();
}

class _MouthRegimenScreenState extends State<MouthRegimenScreen> {
  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(minutes: 2, seconds: 20), (timer) {
    //   context.read<MouthBloc>().add(CheckingDone());
    //   print('test');
    //   if (context.read<MouthBloc>().state.regimenStatus == RegimenStatus.done) {
    //     timer.cancel();
    //   }
    // });
  }

  List<InsulinType> insulinType = InsulinType.values;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MouthBloc(),
      child: Expanded(
          child: Column(
        children: [
          textBox('Tạm ngưng các thuốc hạ đường huyết'),
          textBox(
              'Truyền glucose 10% 500ml pha truyền 5UI ${EnumToString.enumToString(InsulinType.actrapid)} hoặc Nutriflex pha truyền 9UI ${EnumToString.enumToString(InsulinType.actrapid)}'),
          BlocBuilder<MouthBloc, MouthState>(builder: (context, state) {
            if (state.regimenStatus == RegimenStatus.checkingGlucose ||
                state.regimenStatus == RegimenStatus.error) {
              return inputBox('Nhập đường huyêt', (value) {
                context
                    .read<MouthBloc>()
                    .add(CheckGlucose(glucoseLevel: double.parse(value)));
              });
            } else if (state.regimenStatus == RegimenStatus.waiting) {
              return TimeCheck(
                  time: DateTime.now().add(const Duration(minutes: 1)));
            } else {
              return textBox('Thành công chuyển qua hội chuẩn');
            }
          }),
          BlocBuilder<MouthBloc, MouthState>(builder: ((context, state) {
            if (state.regimenStatus == RegimenStatus.waiting) {
              if (state.glucoseLevel > 8.3 && state.glucoseLevel <= 11.1) {
                return textBox(
                    'Truyền dung dịch ${EnumToString.enumToString(InsulinType.actrapid)} 2UI');
              } else if (state.glucoseLevel > 11.1) {
                return textBox(
                    'Truyền dung dịch ${EnumToString.enumToString(InsulinType.actrapid)} 4UI');
              } else if (state.glucoseLevel >= 3.9 &&
                  state.glucoseLevel <= 8.3) {
                return textBox('Đạt mục tiêu lần ${state.doneList.length}');
              } else {
                return textBox('Đường huyết không hợp lệ vui lòng nhập lại');
              }
            } else {
              return Container();
            }
          })),
          BlocBuilder<MouthBloc, MouthState>(builder: (context, state) {
            context.read<MouthBloc>().add(CheckingDone());
            return Container();
          })
        ],
      )),
    );
  }
}
