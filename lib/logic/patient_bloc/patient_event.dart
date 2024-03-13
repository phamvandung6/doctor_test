part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class GetAllPatients extends PatientEvent {
  final Room room;

  const GetAllPatients({required this.room});
  @override
  List<Object> get props => [room];
}

class ChoosePatient extends PatientEvent {
  final Patient chosenPatient;

  const ChoosePatient({required this.chosenPatient});
  @override
  List<Object> get props => [chosenPatient];
}

class AddPatient extends PatientEvent {
  final Patient patient;
  const AddPatient({
    required this.patient,
  });

  @override
  List<Object> get props => [patient];
}

class UpdatePatientProcedure extends PatientEvent {
  final String procedureType;
  final Room room;
  const UpdatePatientProcedure({
    required this.room,
    required this.procedureType,
  });

  @override
  List<Object> get props => [procedureType, room];
}

class RemovePatient extends PatientEvent {
  final Patient patient;
  const RemovePatient({
    required this.patient,
  });

  @override
  List<Object> get props => [patient];
}

class DeletePatient extends PatientEvent {
  final Patient patient;
  const DeletePatient({
    required this.patient,
  });

  @override
  List<Object> get props => [patient];
}

//3rd
class RestorePatient extends PatientEvent {
  final Patient patient;
  const RestorePatient({
    required this.patient,
  });

  @override
  List<Object> get props => [patient];
}

// //4th
class DeleteAllPatients extends PatientEvent {}
