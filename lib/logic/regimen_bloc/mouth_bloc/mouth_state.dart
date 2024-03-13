part of 'mouth_bloc.dart';

class MouthState extends Equatable {
  const MouthState({
    this.regimenStatus = RegimenStatus.checkingGlucose,
    this.glucoseLevel = 0.0,
    this.doneList = const <bool>[],
    this.room = const Room(),
    this.patient = const Patient(),
  });
  final RegimenStatus regimenStatus;
  final double glucoseLevel;
  final List<bool> doneList;
  final Room room;
  final Patient patient;
  MouthState copyWith({
    RegimenStatus? regimenStatus,
    double? glucoseLevel,
    List<bool>? doneList,
    Room? room,
    Patient? patient,
  }) {
    return MouthState(
      regimenStatus: regimenStatus ?? this.regimenStatus,
      glucoseLevel: glucoseLevel ?? this.glucoseLevel,
      doneList: doneList ?? this.doneList,
      room: room ?? this.room,
      patient: patient ?? this.patient,
    );
  }

  int getDoneTime() {
    int count = 0;
    for (var i = 0; i < doneList.length; i++) {
      if (doneList[i] == true) {
        count++;
      }
    }
    return count;
  }

  @override
  List<Object> get props =>
      [regimenStatus, glucoseLevel, doneList, room, patient];
}
