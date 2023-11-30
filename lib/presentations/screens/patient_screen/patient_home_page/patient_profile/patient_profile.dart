import 'package:flutter/material.dart';

import '../patient_home_page.dart';

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
      child: Column(
        children: [
          const CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
                'https://ss-images.saostar.vn/wwebp700/2019/04/17/4989823/z7.jpg'),
            backgroundColor: Colors.transparent,
          ),
          Text(
            widget.patient.name,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Id: ${widget.patient.id}',
              ),
              Text(
                'Ngày sinh: ${widget.patient.birthday}',
              ),
              Text(
                'Giới tính: ${widget.patient.gender}',
              ),
              Text(
                'Số điện thoại: ${widget.patient.phone}',
              ),
              Text(
                'Chiều cao: ${widget.patient.height}',
              ),
              Text(
                'Cân nặng: ${widget.patient.weight}',
              ),
              Text(
                'Địa chỉ: ${widget.patient.address}',
              ),
            ],
          )
        ],
      ),
    );
  }
}
