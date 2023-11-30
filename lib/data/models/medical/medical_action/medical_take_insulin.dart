import 'package:doctor_test/utils/enums/enum.dart';
import 'package:doctor_test/utils/enums/enum_to_enum.dart';
import 'package:doctor_test/utils/enums/enum_to_string.dart';

import 'medical_action.dart';

// ignore: must_be_immutable
class MedicalTakeInsulin extends MedicalAction {
  InsulinType insulinType;
  num insulinUI;
  num recommendedInsulinUI;
  MedicalTakeInsulin({
    required this.insulinType,
    required super.time,
    required this.insulinUI,
    this.recommendedInsulinUI = 0,
  });

  @override
  List<Object?> get props =>
      [time, insulinType, insulinUI, recommendedInsulinUI];
  @override
  MedicalTakeInsulin clone() {
    return MedicalTakeInsulin(
      insulinType: insulinType,
      time: time,
      insulinUI: insulinUI,
      recommendedInsulinUI: recommendedInsulinUI,
    );
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': 'MedicalTakeInsulin',
      'time': time,
      'insulinType': EnumToString.enumToString(insulinType),
      'insulinUI': insulinUI,
      'recommendedInsulinUI': recommendedInsulinUI,
    };
  }

  //fromMap
  factory MedicalTakeInsulin.fromMap(Map<String, dynamic>? map) {
    if (map == null) return errorMedicalTakeInsulin;
    try {
      return MedicalTakeInsulin(
        insulinType: StringToEnum.stringToInsulinType(map['insulinType']),
        time: map['time'].toDate(),
        insulinUI: map['insulinUI'],
        recommendedInsulinUI: map['recommendedInsulinUI'],
      );
    } catch (e) {
      return errorMedicalTakeInsulin;
    }
  }

  @override
  String toString() {
    return '($insulinUI $insulinType lúc $time)';
  }

  String toNiceString() {
    String insulinType = EnumToString.enumToString(this.insulinType);
    String amount = insulinUI.toString();
    return '$amount $insulinType UI';
  }
}

//error MedicalTakeInsulin
MedicalTakeInsulin errorMedicalTakeInsulin = MedicalTakeInsulin(
  insulinType: InsulinType.actrapid,
  time: DateTime(1999),
  insulinUI: 0,
  recommendedInsulinUI: 0,
);
