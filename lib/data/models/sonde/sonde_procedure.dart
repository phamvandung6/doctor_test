import 'package:doctor_test/data/models/medical/medical_procedure.dart';
import 'package:flutter/material.dart';

class SondeProcedure extends MedicalProcedure {
  String status;
  SondeProcedure(
      {this.status = 'ok',
      required super.beginTime,
      required super.state,
      required super.regimens})
      : super(
          name: 'SondeProcedure',
        );
  static Widget get officialName {
    return const Text('Phác đồ cho bệnh nhân ĐTĐ nuôi dưỡng qua sonde',
        //bôi đậm
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
  //1. attributes
}
