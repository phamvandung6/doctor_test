import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/data/models/model_export.dart';
import 'package:doctor_test/utils/popup_menu.dart';
import 'package:flutter/material.dart';

class PatientTile extends StatelessWidget {
  const PatientTile({super.key, required this.patient, required this.room});
  final Patient patient;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      tileColor: const Color(0xffFAF6F0),
      leading: CircleAvatar(
        backgroundColor: const Color(0xff9EB8D9),
        child: Text(patient.id),
      ),
      title: Text('Tên bệnh nhân: ${patient.name}'),
      subtitle: Text('Id: ${patient.id}'),
      trailing: PopupMenu(
        deleteCallBack: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Xác nhận xóa'),
                content: const Text(
                  'Bạn có chắc chắn muốn xóa bệnh nhân này không?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      PatientProvider.deletePatient(
                        room: room,
                        patient: patient,
                      );

                      Navigator.pop(context);
                    },
                    child: const Text('Xóa'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Hủy'),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
