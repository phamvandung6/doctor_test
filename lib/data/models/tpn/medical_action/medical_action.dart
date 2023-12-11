import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MedicalAction extends Equatable {
  final Timestamp time;
  const MedicalAction({
    required this.time,
  });

  MedicalAction copyWith({
    Timestamp? time,
  }) {
    return MedicalAction(
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
    };
  }

  factory MedicalAction.fromMap(Map<String, dynamic> map) {
    return MedicalAction(
      time: map['time'] as Timestamp,
    );
  }

  @override
  List<Object> get props => [time];
}
