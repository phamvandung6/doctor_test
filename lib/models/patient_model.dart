import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String patientId;
  final String patientName;
  final String patientRoom;
  
  //id on firebase
  final String id;

  const Patient({
    required this.patientId,
    required this.patientName,
    required this.patientRoom,
    required this.id,
  });

  Patient copyWith({
    String? patientId,
    String? patientName,
    String? patientRoom,
    String? id,
  }) {
    return Patient(
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientRoom: patientRoom ?? this.patientRoom,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patientId': patientId,
      'patientName': patientName,
      'patientRoom': patientRoom,
      'id': id,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      patientId: map['patientId'] as String,
      patientName: map['patientName'] as String,
      patientRoom: map['patientRoom'] as String,
      id: map['id'] as String,
    );
  }

  @override
  List<Object> get props => [patientId, patientName, patientRoom];
}
