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

class AddPatient extends PatientEvent {
  final Patient patient;
  const AddPatient({
    required this.patient,
  });

  @override
  List<Object> get props => [patient];
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
