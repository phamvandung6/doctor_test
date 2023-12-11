import 'package:doctor_test/data/data_provider/patient_provider.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_home_page/list_procedure_screen/create_procedure_form.dart';
import 'package:doctor_test/presentations/screens/patient_screen/patient_home_page/treatment/tpn/tpn_treatment.dart';
import 'package:doctor_test/utils/popup_menu.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/model_export.dart';

class ListProcedure extends StatelessWidget {
  const ListProcedure({
    super.key,
    required this.room,
    required this.patient,
  });

  final Room room;
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: StreamBuilder(
        stream: PatientProvider.getProcedures(room: room, patient: patient),
        builder: (context, snapshot) {
          final procedures = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('Đã có lỗi xảy ra'));
              } else {
                return Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CreateProcedureForm(
                                room: room, patient: patient);
                          }));
                        },
                        child: const Text("Tạo phác đồ mới")),
                    Text('Có ${procedures!.length} phác đồ đang điều trị'),
                    _listProcedures(procedures),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Expanded _listProcedures(List<Procedure> procedures) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: procedures.length,
        itemBuilder: (context, index) {
          final procedure = procedures[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Treatment(
                    patient: patient,
                  );
                }));
              },
              tileColor: const Color.fromARGB(255, 255, 255, 255),
              leading: CircleAvatar(
                backgroundColor: const Color(0xffA6E3E9),
                child: Text(room.roomName),
              ),
              title: Text('Tên phác đồ: ${procedure.procedureType}'),
              subtitle: Text('Ngày điều trị: ${procedure.currentProcedureId}'),
              trailing: PopupMenu(
                deleteCallBack: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Xác nhận xóa'),
                        content: Text(
                          'Bạn có chắc chắn muốn xóa ${procedure.procedureType} không?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {},
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
            ),
          );
        },
      ),
    );
  }
}
