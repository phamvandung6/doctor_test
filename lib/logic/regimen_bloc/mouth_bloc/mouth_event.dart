part of 'mouth_bloc.dart';

abstract class MouthEvent extends Equatable {
  const MouthEvent();

  @override
  List<Object> get props => [];
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
