import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MedicalAction extends Equatable {
  DateTime time;

  MedicalAction({
    required this.time,
  });
  @override
  String toString() {
    return 'MedicalAction [time : $time]';
  }

  MedicalAction clone() {
    return MedicalAction(time: time);
  }
  
  @override
  List<Object?> get props => [time];
}
