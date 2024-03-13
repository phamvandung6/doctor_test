part of 'patient_bloc.dart';

class PatientState extends Equatable {
  const PatientState({
    this.allPatients = const <Patient>[],
    this.chosenPatient = const Patient(),
    this.room = const Room(),
  });

  final List<Patient> allPatients;
  final Patient chosenPatient;
  final Room room;

  PatientState copyWith({
    List<Patient>? allPatients,
    Patient? chosenPatient,
    Room? room,
  }) {
    return PatientState(
      allPatients: allPatients ?? this.allPatients,
      chosenPatient: chosenPatient ?? this.chosenPatient,
      room: room ?? this.room,
    );
  }

  @override
  List<Object> get props => [allPatients, chosenPatient, room];
}
