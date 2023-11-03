part of 'patient_bloc.dart';

class PatientState extends Equatable {
  const PatientState({
    this.allPatients = const <Patient>[],
  });

  final List<Patient> allPatients;

  @override
  List<Object> get props => [allPatients];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allPatients': allPatients.map((x) => x.toMap()).toList(),
    };
  }

  factory PatientState.fromMap(Map<String, dynamic> map) {
    return PatientState(
      allPatients: List<Patient>.from(
        (map['allPatients'] as List<int>).map<Patient>(
          (x) => Patient.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
