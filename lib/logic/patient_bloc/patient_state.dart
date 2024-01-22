part of 'patient_bloc.dart';

class PatientState extends Equatable {
  const PatientState({
    this.allPatients = const <Patient>[],
    this.chosenPatient = const Patient(),
  });

  final List<Patient> allPatients;
  final Patient chosenPatient;

  @override
  List<Object> get props => [allPatients, chosenPatient];
}
