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
              final time = DateTime.now().add(const Duration(minutes: 1));
              return TimeCheck(
                  time: time,
                  onDone: (timer) {
                    if (DateTime.now().hour == time.hour &&
                        DateTime.now().minute == time.minute &&
                        DateTime.now().second == time.second) {
                      context.read<MouthBloc>().add(CheckingTime(time: time));
                      timer.cancel();
                    }
                  });
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
            Timer? _timer;
            if (state.regimenStatus == RegimenStatus.waiting) {
              context.read<MouthBloc>().add(CheckingDone());
              if (state.doneList.last == false) {
                _timer = Timer.periodic(const Duration(minutes: 1, seconds: 20),
                    (timer) {
                  if (state.doneList.last == true) {
                    timer.cancel();
                    _timer = null;
                  }
                  print(DateTime.now());
                });
              }
            } else {
              _timer = null;
            }
            return Container();
          })
        ],
      )),
    );
  }
}
