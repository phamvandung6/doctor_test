import 'package:equatable/equatable.dart';

class Procedure extends Equatable {
  final String procedureType;
  final String currentProcedureId;
  
  const Procedure({
    required this.procedureType,
    required this.currentProcedureId,
  });

  @override
  List<Object> get props => [procedureType, currentProcedureId];

  Procedure copyWith({
    String? procedureType,
    String? currentProcedureId,
  }) {
    return Procedure(
      procedureType: procedureType ?? this.procedureType,
      currentProcedureId: currentProcedureId ?? this.currentProcedureId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'procedureType': procedureType,
      'currentProcedureId': currentProcedureId,
    };
  }

  factory Procedure.fromMap(Map<String, dynamic> map) {
    return Procedure(
      procedureType: map['procedureType'] as String,
      currentProcedureId: map['currentProcedureId'] as String,
    );
  }
}
