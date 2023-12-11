import 'package:cloud_firestore/cloud_firestore.dart';

import 'medical_action.dart';

class MedicalMixing extends MedicalAction {
  const MedicalMixing({required super.time});

  @override
  MedicalMixing copyWith({
    double? glucoseUI,
    Timestamp? time,
  }) {
    return MedicalMixing(
      time: time ?? this.time,
    );
  }

  @override
  String toString() {
    return 'Truyền glucose 10% 500ml pha truyền 10UI Actrapid (100ml/h).';
  }

  static String get guideline {
    return 'Truyền glucose 10% 500ml pha truyền 10UI Actrapid (100ml/h).';
  }

  static String get doingLine {
    return 'Đang truyền glucose 10% 500ml pha truyền 10UI Actrapid (100ml/h).';
  }

  //toMap
  @override
  Map<String, dynamic> toMap() {
    return {
      'name': 'MedicalMixing',
      'time': time,
    };
  }

  factory MedicalMixing.fromMap(Map<String, dynamic> map) {
    return MedicalMixing(
      time: map['time'] as Timestamp,
    );
  }
}
