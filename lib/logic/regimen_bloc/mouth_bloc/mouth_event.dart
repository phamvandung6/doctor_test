part of 'mouth_bloc.dart';

abstract class MouthEvent extends Equatable {
  const MouthEvent();

  @override
  List<Object> get props => [];
}

class AddRoomPatient extends MouthEvent {
  final Room room;
  final Patient patient;
  const AddRoomPatient({
    required this.room,
    required this.patient,
  });

  @override
  List<Object> get props => [room, patient];
}

class CheckGlucose extends MouthEvent {
  final double glucoseLevel;
  const CheckGlucose({
    required this.glucoseLevel,
  });

  @override
  List<Object> get props => [glucoseLevel];
}

class CheckingTime extends MouthEvent {
  final DateTime time;
  const CheckingTime({
    required this.time,
  });

  @override
  List<Object> get props => [time];
}

class CheckingDone extends MouthEvent {
  final DateTime time;
  const CheckingDone({
    required this.time,
  });
  @override
  List<Object> get props => [time];
}

class AddingDone extends MouthEvent {
  final bool done;
  const AddingDone({
    required this.done,
  });
  @override
  List<Object> get props => [done];
}

class GuideMixing extends MouthEvent {}
