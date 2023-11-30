import 'package:doctor_test/data/models/medical/medical_procedure.dart';
import 'package:flutter/material.dart';

class TPNProcedure extends MedicalProcedure {
  String status;
  TPNProcedure(
      {this.status = 'ok',
      required super.beginTime,
      required super.state,
      required super.regimens})
      : super(name: 'TPNProcedure');

  @override
  String toString() {
    return '''TPNProcedure: 
      {beginTime: $beginTime,\n state: $state,\n regimens: $regimens}
       ''';
  }

  static Widget get officialName {
    return const Text(
        'Phác đồ cho bệnh nhân ĐTĐ nuôi dưỡng bằng đường tĩnh mạch',
        //bôi đậm
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}
