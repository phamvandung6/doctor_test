import 'package:cloud_firestore/cloud_firestore.dart';

import 'medical_action.dart';

class MedicalCheckGlucose extends MedicalAction {
  final double glucoseUI;
  const MedicalCheckGlucose({
    required this.glucoseUI,
    required super.time,
  });

  @override
  MedicalCheckGlucose copyWith({
    double? glucoseUI,
    Timestamp? time,
  }) {
    return MedicalCheckGlucose(
      glucoseUI: glucoseUI ?? this.glucoseUI,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': 'MedicalCheckGlucose',
      'glucoseUI': glucoseUI,
      'time': time,
    };
  }

  factory MedicalCheckGlucose.fromMap(Map<String, dynamic> map) {
    return MedicalCheckGlucose(
      glucoseUI: map['glucoseUI'] as double,
      time: map['time'] as Timestamp,
    );
  }

  @override
  String toString() => 'MedicalCheckGlucose(glucoseUI: $glucoseUI)';
}
