import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:doctor_test/utils/enums/enum.dart';
import 'package:doctor_test/utils/enums/enum_to_enum.dart';

import 'medical_action.dart';

class MedicalTakeInsulin extends MedicalAction {
  final InsulinType insulinType;
  final double insulinUI;
  final double recommendInsulinUI;

  const MedicalTakeInsulin(
      this.insulinType, this.insulinUI, this.recommendInsulinUI,
      {required super.time});

  @override
  MedicalTakeInsulin copyWith({
    InsulinType? insulinType,
    double? insulinUI,
    double? recommendInsulinUI,
    Timestamp? time,
  }) {
    return MedicalTakeInsulin(
      insulinType ?? this.insulinType,
      insulinUI ?? this.insulinUI,
      recommendInsulinUI ?? this.recommendInsulinUI,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'insulinType': insulinType,
      'insulinUI': insulinUI,
      'name': 'MedicalTakeInsulin',
      'time': time,
    };
  }

  factory MedicalTakeInsulin.fromMap(Map<String, dynamic> map) {
    return MedicalTakeInsulin(
      StringToEnum.stringToInsulinType(map['insulinType']),
      map['insulinUI'] as double,
      map['recommendInsulinUI'] as double,
      time: map['time'] as Timestamp,
    );
  }
  @override
  String toString() {
    return '($insulinUI $insulinType lúc $time)';
  }
}
