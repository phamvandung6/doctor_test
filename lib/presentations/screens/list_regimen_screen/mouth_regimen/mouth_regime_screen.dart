import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/enums/enum.dart';
import '../../../../utils/enums/enum_to_string.dart';

class MouthRegimenScreen extends StatefulWidget {
  const MouthRegimenScreen({Key? key}) : super(key: key);
  @override
  State<MouthRegimenScreen> createState() => _MouthRegimenScreenState();
}

class _MouthRegimenScreenState extends State<MouthRegimenScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MouthBloc>(
          create: (context) => MouthBloc()
            ..add(AddRoomPatient(
                room: context.read<RoomBloc>().state.chosenRoom,
                patient: context.read<PatientBloc>().state.chosenPatient)),
        ),
        BlocProvider<TimeBloc>(
          create: (context) => TimeBloc(),
        ),
      ],
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
              context.read<MouthBloc>().add(CheckingTime(time: DateTime.now()));
              return Text(
                'Kiểm tra lại lượng glucose sau ${time.hour}:${time.minute}:${time.second} ngày ${time.day}/${time.month}/${time.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              );
            } else if (state.regimenStatus == RegimenStatus.done) {
              return textBox('Thành công chuyển qua hội chuẩn');
            } else {
              return Container();
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
                context.read<TimeBloc>().add(TimeStarted());
                return textBox('Đạt mục tiêu lần ${state.getDoneTime()}');
              } else {
                return textBox('Đường huyết không hợp lệ vui lòng nhập lại');
              }
            } else {
              return Container();
            }
          })),
          BlocBuilder<TimeBloc, TimeState>(builder: (context, state) {
            if (!state.isDone1) {
              context.read<TimeBloc>().add(TimeTicked());
            }
            if (state.isDone) {
              return Container();
            } else {
              context.read<MouthBloc>().add(GuideMixing());
              return const Text(
                  'Đã 2 ngày không đạt được kết quả chuyển sang phương pháp điều trị khác');
            }
          })
        ],
      )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
