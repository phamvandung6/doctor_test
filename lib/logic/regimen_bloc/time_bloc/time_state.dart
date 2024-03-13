part of 'time_bloc.dart';

class TimeState extends Equatable {
  final DateTime time;
  final bool isDone;
  final bool isDone1;

  const TimeState(
      {required this.time, this.isDone = true, this.isDone1 = false});
  TimeState copyWith({DateTime? time, bool? isDone, bool? isDone1}) {
    return TimeState(
        time: time ?? this.time,
        isDone: isDone ?? this.isDone,
        isDone1: isDone1 ?? this.isDone1);
  }

  @override
  List<Object> get props => [time, isDone, isDone1];
}
