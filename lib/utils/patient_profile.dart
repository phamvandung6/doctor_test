import 'package:flutter/material.dart';

import '../logic/export_bloc.dart';
import '../presentations/screens/patient_home_page/patient_home_page.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({
    super.key,
    required this.widget,
  });

  final PatientHomePage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          return Column(
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    'https://ss-images.saostar.vn/wwebp700/2019/04/17/4989823/z7.jpg'),
                backgroundColor: Colors.transparent,
              ),
              Text(
                context.read<PatientBloc>().state.chosenPatient.name!,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Id: ${context.read<PatientBloc>().state.chosenPatient.id}',
                  ),
                  Text(
                    'Ngày sinh: ${context.read<PatientBloc>().state.chosenPatient.birthday?.toDate().toString().substring(0, 10)}',
                  ),
                  Text(
                    'Giới tính: ${context.read<PatientBloc>().state.chosenPatient.gender}',
                  ),
                  Text(
                    'Số điện thoại: ${context.read<PatientBloc>().state.chosenPatient.phone}',
                  ),
                  Text(
                    'Chiều cao: ${context.read<PatientBloc>().state.chosenPatient.height}',
                  ),
                  Text(
                    'Cân nặng: ${context.read<PatientBloc>().state.chosenPatient.weight}',
                  ),
                  Text(
                    'Địa chỉ: ${context.read<PatientBloc>().state.chosenPatient.address}',
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
