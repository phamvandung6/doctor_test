import 'package:bloc/bloc.dart';
import 'package:doctor_test/models/patient_model.dart';
import 'package:doctor_test/models/room_model.dart';
import 'package:doctor_test/repositories/firebase_repository.dart';
import 'package:doctor_test/utils/enums/enum.dart';
import 'package:equatable/equatable.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(const PatientState()) {
    on<AddPatient>(_onAddPatient);
    on<GetAllPatients>(_onGetAllPatients);
    on<DeletePatient>(_onDeletePatient);
    on<ChoosePatient>(_onChoosePatient);
    on<UpdatePatientProcedure>(_onUpdatePatientProcedure);
    // on<RemovePatient>(_onRemovePatient);
    // on<RestorePatient>(_onRestorePatient);
  }
  void _onChoosePatient(ChoosePatient event, Emitter<PatientState> emit) {
    emit(PatientState(
      chosenPatient: event.chosenPatient,
    ));
    // print(state.chosenPatient);
  }

  void _onAddPatient(AddPatient event, Emitter<PatientState> emit) async {
    await FirestoreRepository.createPatient(patient: event.patient);
  }

  void _onGetAllPatients(
      GetAllPatients event, Emitter<PatientState> emit) async {
    List<Patient> allPatients = [];

    await FirestoreRepository.getPatients(event.room).then((value) {
      for (var patient in value) {
        allPatients.add(patient);
      }
    });

    emit(PatientState(
      allPatients: allPatients,
    ));
  }

  void _onDeletePatient(DeletePatient event, Emitter<PatientState> emit) async {
    await FirestoreRepository.deletePatient(patient: event.patient);
  }

  void _onUpdatePatientProcedure(
      UpdatePatientProcedure event, Emitter<PatientState> emit) async {
    ProcedureType procedureType = ProcedureType.values
        .firstWhere((e) => e.toString().split('.').last == event.procedureType);
    Patient temp = state.chosenPatient.copyWith(procedureType: procedureType);
    emit(PatientState(
      chosenPatient: temp,
    ));
  }

  //nâng cấp tính năng này sau

  // void _onRemovePatient(RemovePatient event, Emitter<PatientState> emit) async {
  //   Patient removedRoom = event.patient.copyWith(isDeleted: true);
  //   await FirestoreRepository.updatePatient(patient: removedPatient);
  // }

  // void _onRestoreRoom(RestoreRoom event, Emitter<RoomState> emit) async {
  //   Room restoredRoom = event.room.copyWith(
  //     isDeleted: false,
  //   );
  //   await FirestoreRepository.updateRoom(room: restoredRoom);
  // }
}
