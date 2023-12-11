import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:doctor_test/utils/enums/enum.dart';

class TPNModel extends Equatable {
  final Timestamp beginTime;
  final List<dynamic> medicalActions;
  final String name;
  // final TPNStatus status;
  final TPNType treatmenStatus;

  const TPNModel({
    required this.beginTime,
    required this.medicalActions,
    required this.name,
    // required this.status,
    required this.treatmenStatus,
  });

  TPNModel copyWith({
    Timestamp? beginTime,
    List<dynamic>? medicalActions,
    String? name,
    // TPNStatus? status,
    TPNType? treatmenStatus,
  }) {
    return TPNModel(
      beginTime: beginTime ?? this.beginTime,
      medicalActions: medicalActions ?? this.medicalActions,
      name: name ?? this.name,
      // status: status ?? this.status,
      treatmenStatus: treatmenStatus ?? this.treatmenStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beginTime': beginTime,
      'medicalActions': medicalActions,
      'name': name,
      // 'status': status,
      'treatmenStatus': treatmenStatus
    };
  }

  factory TPNModel.fromMap(Map<String, dynamic> map) {
    return TPNModel(
      beginTime: map['beginTime'] as Timestamp,
      medicalActions:
          List<dynamic>.from((map['medicalActions'] as List<dynamic>)),
      name: map['name'] as String,
      // status: map['status'] as TPNStatus,
      treatmenStatus: map['treatmenStatus'] as TPNType,
    );
  }

  @override
  List<Object> get props => [beginTime, medicalActions, name, treatmenStatus];
}
